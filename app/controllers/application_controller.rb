class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_current_cart, except: [:inspect]

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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
    end

    def controller_translate(keyword)
      I18n.t(keyword, scope: params[:controller])
    end

    def combine_error_message(error_messages, model_name)
      messages = []
      error_messages.each_with_index do |message, index|
        messages << "#{index+1}. #{I18n.t("attributes.#{model_name}.#{message.first}")}: #{message.last.join(", ")}"
      end
      messages.join("\n")
    end

    def check_infomation_completeness
      if current_user.present? && !current_user.valid?(:more_info)
        redirect_to more_info_path and return
      end
    end
  private
    def current_cart
      if current_user.present?
        cart = Cart.find_or_create_by(user_id: current_user.id)
      end
    rescue ActiveRecord::RecordNotFound
      # cart = Cart.create
      # cookies[:_c_id] = cart.id
      # cart
    end

    def set_current_cart
      @current_cart = current_cart
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
