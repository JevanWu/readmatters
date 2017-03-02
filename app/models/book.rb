class Book < ActiveRecord::Base

  attr_accessor :cover_url
  before_create :cover_from_url

  has_many :products

  validates :name, :price, :author, :summary, presence: true

  has_attached_file :cover, :default_url => "/images/:style/missing.png",
                            :path => Figaro.env.paperclip_storage_path,
                            :url => Figaro.env.paperclip_storage_path

  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  def cover_from_url
    return true if cover_url.blank?
    self.cover = open(cover_url)
  end
end
