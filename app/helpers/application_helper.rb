module ApplicationHelper
  def render_footer
    if params[:action] != "home"
      render 'layouts/footer'
    end
  end
end
