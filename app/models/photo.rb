class Photo < ApplicationRecord

  belongs_to :product

  has_attached_file :image, :default_url => "/images/:style/missing.png",
                            :styles => { original: ["700x700>", :jpg]},
                            :convert_options => { original: "-strip" },
                            :path => Figaro.env.paperclip_storage_path,
                            :url => Figaro.env.paperclip_storage_url
                            # :convert_options => { medium: "-quality 75 -strip" },

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
