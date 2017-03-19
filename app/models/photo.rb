class Photo < ActiveRecord::Base

  belongs_to :product

  has_attached_file :image, :default_url => "/images/:style/missing.png",
                            :styles => { medium: ["100x100>", :jpg]},
                            :convert_options => { medium: "-quality 75 -strip" },
                            :path => Figaro.env.paperclip_storage_path,
                            :url => Figaro.env.paperclip_storage_url

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
