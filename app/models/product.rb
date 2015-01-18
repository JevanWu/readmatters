require "open-uri"
class Product < ActiveRecord::Base
  attr_accessor :cover_url
  before_create :cover_from_url

  belongs_to :user
  has_many :line_items
  
  has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  def cover_from_url
    self.cover = open(cover_url)
  end
end
