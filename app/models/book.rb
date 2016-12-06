class Book < ActiveRecord::Base

  attr_accessor :cover_url
  before_create :cover_from_url

  has_many :products

  has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  def cover_from_url
    return true if cover_url.blank?
    self.cover = open(cover_url)
  end
end
