module ApplicationHelper
  def render_footer
    unless %w(home book_links).include? params[:action]
      render 'layouts/footer'
    end
  end

  def render_relative_css(file)
    file_path = File.dirname(file)
    file_name = File.basename(file, ".slim")
    file_path.gsub!("views", "assets/stylesheets")
    css_file = "#{file_path}/#{file_name}"
  end
end
