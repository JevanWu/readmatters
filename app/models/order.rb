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

  default_scope { order(created_at: :desc) }

  #order_state (wait_pay, wait_ship, wait_confirm, success, void)
  state_machine :state, initial: :wait_pay do

    after_transition :wait_pay => :wait_ship, :do => :change_product_to_sold

    event :pay do
      transition :wait_pay => :wait_ship
    end

    event :ship do
      transition :wait_ship => :wait_confirm
    end

    event :confirm do
      transition :wait_confirm => :success
    end

    event :cancel do
      transition :wait_pay => :cancelled
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
      line_items << item
    end
  end

  def generate_identifier
    date_string = Time.now.strftime('%Y%m%d')
    uniq_num = "%05d" % Redis.incr("#{self.class.name}:#{date_string}")
    self.identifier = date_string + uniq_num
  end

  private

    def change_product_to_sold
      self.line_items.each do |line_item|
        line_item.product.update(status: :sold)
      end
    end

    def calculate_total_price
      self.total_price = 0.00
      products = Product.where(id: line_items.pluck(:product_id))
      products.each do |product|
        self.total_price += product.price
      end
    end

    def generate_pay_code
      loop do
        pay_code = SecureRandom.random_number(10000).to_s
        break if !Order.exists?(pay_code: pay_code)
      end
      self.pay_code = pay_code
    end
end
