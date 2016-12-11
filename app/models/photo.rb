class Photo < ActiveRecord::Base

  belongs_to :product

  has_attached_file :image, :default_url => "/images/:style/missing.png", :path => ":class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
