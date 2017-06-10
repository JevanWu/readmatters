namespace :utility do

  desc "Generate text template for email"
  task :generate_mail_text_template, [:mail_template_name] do |t, args|
    template_dir = "mailer"
    template_name = args.mail_template_name

    templates = template_name.present? ? [template_name] : Dir.entries("app/views/#{template_dir}") - [".", ".."]

    templates.each do |template|
      if template.match("erb")
        template = template.split(".").first
      end

      content = File.read(Rails.root.join('app', 'views', template_dir, "#{template}.html.erb"))
      text = ActionView::Base.full_sanitizer.sanitize(content).gsub(" ", "").gsub(/[\n]+/, "\n").strip
      file = File.new(Rails.root.join('app', 'views', template_dir, "#{template}.text.erb"), "w")
      file.puts(text)
    end
  end
end
