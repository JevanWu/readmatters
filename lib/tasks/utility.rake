namespace :utility do

  desc "Generate text template for email"
  task :generate_mail_text_template, [:mail_template_name] do |t, args|
    template_dir = "mailer"
    template_name = args.mail_template_name

    content = File.read(Rails.root.join('app', 'views', template_dir, "#{template_name}.html.erb"))
    text = ActionView::Base.full_sanitizer.sanitize(content).gsub(" ", "").gsub(/[\n]+/, "\n").strip
    file = File.new(Rails.root.join('app', 'views', template_dir, "#{template_name}.text.erb"), "w")
    file.puts(text)
  end
end
