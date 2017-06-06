class Book < ApplicationRecord

  # attr_accessor :cover_url
  # before_create :cover_from_url
  acts_as_taggable_on :categories

  has_many :products

  validates :name, :price, :author, :summary, :original_cover, :category_list, presence: true

  has_attached_file :cover, :default_url => "/images/:style/missing.png",
                            :path => Figaro.env.paperclip_storage_path,
                            :url => Figaro.env.paperclip_storage_url

  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  def cover_from_url
    return true if cover_url.blank?
    self.cover = open(cover_url)
  end
end
