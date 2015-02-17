class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  belongs_to :province
  belongs_to :city
  belongs_to :district

  before_create :generate_identifier

  default_scope { order(created_at: :desc) }

  #order_state (wait_pay, wait_ship, wait_confirm, success, void)
  state_machine :state, initial: :wait_pay do

    event :pay do
      transition :wait_pay => :wait_ship
    end

    event :ship do
      transition :wait_ship => :wait_confirm
    end

    event :confirm do
      transition :wait_confirm => :success
    end

  end

  def add_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def generate_identifier
    date_string = Time.now.strftime('%Y%m%d')
    uniq_num = "%05d" % $redis.incr("#{self.class.name}:#{date_string}")
    self.identifier = date_string + uniq_num
  end
end
