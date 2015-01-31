module PagesHelper

  def current_cart
    Cart.find(session[:card_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:card_id] = cart.id
    cart
  end
end
