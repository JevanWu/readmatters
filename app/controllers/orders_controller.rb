class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:inspect]
  before_action :check_order_owner, only: [:ship, :confirm, :cancel]
  before_action :set_order, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:inspect]

  def new
    @seller_id = params[:seller_id]
    redirect_to cart_path, flash: { alert: "请重新点击下单" } if @seller_id.blank?
    @order = current_user.bought_orders.build if current_user.present?
    @line_items = current_cart.line_items.eager_load(:product).where("products.user_id = ? and products.status = ?", @seller_id, "normal")
  end

  def create_free
    @seller_id = params[:seller_id]
    redirect_to cart_path if @seller_id.blank?
    ActiveRecord::Base.transaction do
      @order = current_user.bought_orders.new(seller_id: @seller_id)
      # 加入商品
      @order.add_items_from_cart(current_cart)
      # 计算价格
      @order.calculate_total_price

      if @order.switch_to_free
        conversation = @order.send_order_info_message
        redirect_to chat_path(chat_id: conversation.id)
      else
        redirect_back(fallback_location: cart_path, flash: { alert: combine_error_message(@order.errors.messages, "order")})
      end
    end
  end

  def create
    if current_cart.line_items.blank?
      return redirect_back(fallback_location: root_url, flash: { error: controller_translate("can_not_buy") })
    end
    ActiveRecord::Base.transaction do
      @order = current_user.bought_orders.build(order_params)
      @order.seller_id = params[:order][:seller_id]
      @order.province_id = params[:order][:province]
      @order.city_id = params[:order][:city]
      @order.district_id = params[:order][:district]
      # 加入商品
      @order.add_items_from_cart(current_cart)
      # 计算价格
      @order.calculate_total_price
      if @order.save
        redirect_to checkout_path(@order)
      else
        redirect_back(fallback_location: root_url, flash: { alert: combine_error_message(@order.errors.messages, "order") })
      end
    end
  end

  def checkout
    @order = Order.find(params[:id])
    SlackNotifier.ping("#{current_user.email}进入订单结算页面啦！Order ID: #{@order.id}. 可在#{admin_order_url(@order)}查看")
    redirect_back(fallback_location: root_url) if !%(wait_pay free).include?(@order.state)
  end

  def ship
    @order.ship if @order.present?
    respond_to do |format|
      format.html { redirect_to sold_orders_path, flash: { notice: "状态更新成功"} }
      format.js { render "update_order_item", layout: false }
    end
  end

  def confirm
    @order.confirm if @order.present?
    respond_to do |format|
      format.html { redirect_to bought_orders_path, flash: { notice: "状态更新成功"} }
      format.js { render "update_order_item", layout: false }
    end
  end

  def inspect
    pay_code, amount = params[:pay_code], params[:amount]
    # OrderInspector.delay.inspect(pay_code, amount)
    symbol, price = amount.split(" ")
    puts "paycode: #{pay_code}, price: #{price} --------------------------------------"
    render json: "ok", status: :ok
  end

  def bought_orders
    @orders = current_user.bought_orders
    render "index"
  end

  def sold_orders
    @orders = current_user.sold_orders
    render "index"
  end

  def show
    if @order.seller_id == current_user.id
      redirect_to sold_orders_path
    elsif @order.buyer_id == current_user.id
      redirect_to bought_orders_path
    end
  end

  def cancel
    @order.failure if @order.present?
    respond_to do |format|
      format.html { redirect_to sold_orders_path, flash: { notice: "状态更新成功"} }
      format.js { render "update_order_item", layout: false }
    end
  end

  private

    def order_params
      params.require(:order).permit(:receiver_name, :receiver_phone, :street)
    end

    def set_order
      @order = Order.find_by!(identifier: params[:id])
    end

    def check_order_owner
      @order = Order.find_by!(identifier: params[:id])
      if current_user.blank? || (current_user.id != @order.seller_id && current_user.id != @order.buyer_id)
        redirect_to bought_orders_path, flash: { alert: "无权操作" }
      end
    end
end
