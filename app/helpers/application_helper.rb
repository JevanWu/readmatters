module ApplicationHelper
  def render_footer
    unless %w(home book_links).include? params[:action]
      render 'layouts/footer'
    end
  end
end
