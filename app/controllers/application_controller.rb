class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  layout :proper_layout

  def proper_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :name) }
    end

  private
    def current_cart
      Cart.find(session[:card_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:card_id] = cart.id
      cart
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
