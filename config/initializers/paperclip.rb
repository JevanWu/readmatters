if Rails.env.production?
  Paperclip::Attachment.default_options[:storage] = :qiniu
  Paperclip::Attachment.default_options[:qiniu_credentials] = {
    :access_key => ENV["QINIU_ACCESS_TOKEN"],
    :secret_key => ENV["QINIU_SECRET_TOKEN"]
  }
  Paperclip::Attachment.default_options[:bucket] = ENV["QINIU_BUCKET"]
  Paperclip::Attachment.default_options[:use_timestamp] = false
  Paperclip::Attachment.default_options[:qiniu_host] = ENV["QINIU_BUCKET_URL"]

  Paperclip.interpolates :image_timestamp do |style, attachment|

    DateTime.now.strftime("%Y%m%d%H%M%S")
    # Time.current.to_i
  end
end

