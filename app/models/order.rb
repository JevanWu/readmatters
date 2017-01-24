class Order < ActiveRecord::Base
  belongs_to :buyer, class_name: "User", foreign_key: "user_id"
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  has_many :line_items
  belongs_to :province
  belongs_to :city
  belongs_to :district

  before_create :generate_identifier
  before_create :calculate_total_price
  before_create :generate_pay_code
  after_create :lock_products
  #after_create :check_expiration

  default_scope { order(created_at: :desc) }

  validates :province_id, :city_id, :district_id, :street, :receiver_name, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  #order_state (wait_pay, failure, wait_ship, wait_confirm, success, wait_refund, refunded)
  state_machine :state, initial: :wait_pay do

    after_transition :wait_pay => :wait_ship, :do => :change_product_to_sold
    after_transition :wait_pay => :failure, :do => :unlock_products

    after_transition :wait_pay => :wait_ship, :do => :send_buyer_paid_notification
    after_transition :wait_pay => :wait_ship, :do => :send_seller_ship_notification

    after_transition :wait_ship => :wait_confirm, :do => :send_buyer_confirm_notification

    after_transition :wait_confirm => :success, :do => :send_seller_success_notification

    event :pay do
      transition :wait_pay => :wait_ship
    end

    event :ship do
      transition :wait_ship => :wait_confirm
    end

    event :confirm do
      transition :wait_confirm => :success
    end

    event :failure do
      transition :wait_pay => :failure
    end

    event :cancel do
      transition :wait_ship => :wait_refund
    end

    event :refund do
      transition :wait_refund => :refunded
    end

  end

  def add_items_from_cart(cart, seller_id=nil)
    if seller_id.present?
      items = cart.line_items.eager_load(:product).where("products.user_id = ?", seller_id)
    else
      items = cart.line_items
    end
    items.each do |item|
      item.cart_id = nil
      # 不有效的商品不加入订单
      next if !item.product.available?
      line_items << item
    end
  end

  def generate_identifier
    date_string = Time.now.strftime('%Y%m%d')
    uniq_num = "%05d" % Redis.current.incr("#{self.class.name}:#{date_string}")
    self.identifier = date_string + uniq_num
  end

  # 10分钟没有付款就算过期订单
  def expired?
    created_at < 10.minutes.ago
  end

  def calculate_total_price
    self.total_price = 0.00
    products = Product.where(id: line_items.map(&:product_id))
    products.each do |product|
      self.total_price += product.price
    end
  end

  def book_names
    self.line_items.map(&:product).map(&:book).map(&:name)
  end

  private

    def lock_products
      self.line_items.each do |line_item|
        product = line_item.product
        next if !product.status.normal?
        line_item.product.update(status: :locked)
      end
    end

    def unlock_products
      self.line_items.each do |line_item|
        product = line_item.product
        next if !product.status.locked?
        product.update(status: :normal)
      end
    end

    def change_product_to_sold
      self.line_items.each do |line_item|
        line_item.product.update(status: :sold)
      end
    end

    def generate_pay_code
      pay_code = nil
      loop do
        pay_code = SecureRandom.random_number(10000).to_s
        break if !Order.exists?(pay_code: pay_code)
      end
      raise Exception.new("Pay code生成出错") if !pay_code.present?
      self.pay_code = pay_code
    end

    def check_expiration
      OrderExpirationChecker.perform_in(10.minutes, self.id)
    end

    # 通知邮件
    def send_buyer_paid_notification
      book_names = self.book_names
      Mailer.buyer_paid_success_notification(self.buyer, self, book_names).deliver_later
    end

    def send_seller_ship_notification
      book_names = self.book_names
      Mailer.seller_order_ship_notification(self.seller, self, book_names).deliver_later
    end

    def send_buyer_confirm_notification
      book_names = self.book_names
      Mailer.buyer_order_confirm_notification(self.buyer, self, book_names).deliver_later
    end

    def send_seller_success_notification
      book_names = self.book_names
      Mailer.buyer_order_success_notification(self.buyer).deliver_later
      Mailer.seller_order_success_notification(self.seller).deliver_later
    end
end
