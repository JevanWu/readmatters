require "open-uri"
class Product < ActiveRecord::Base
  extend Enumerize

  attr_accessor :cover_url
  #before_create :cover_from_url

  belongs_to :user
  belongs_to :book
  has_many :line_items
  has_many :photos

  validates :price, presence: true

  enumerize :status, in: [:normal, :locked, :sold], default: :normal, scope: true

  has_attached_file :cover, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  delegate :author_intro, :catalog, to: :book
  delegate :cover, to: :book

  scope :available, -> { with_status(:normal) }
  scope :locked, -> { with_status(:locked) }

  def cover_from_url
    self.cover = open(cover_url)
  end

  def has_photos?
    self.photos.count > 0
  end

  def name
    book.name
  end

  def available?
    self.status.normal?
  end

  def book_price
    self.price || book.price
  end

  def book_summary
    self.summary || book.summary
  end

  def book_tags
    self.tags_before_type_cast || book.tags
  end
end
