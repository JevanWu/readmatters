require "open-uri"
class Product < ApplicationRecord
  extend Enumerize

  #attr_accessor :cover_url
  #before_create :cover_from_url

  belongs_to :user
  belongs_to :book
  has_many :line_items
  has_many :photos

  alias :owner :user

  validates :price, :summary, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enumerize :status, in: [:normal, :locked, :sold, :withdrawn], default: :normal, scope: true

  # has_attached_file :cover, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  delegate :author_intro, :cover, :original_cover, :category_list, :catalog, to: :book

  scope :available, -> { with_status(:normal) }
  scope :locked, -> { with_status(:locked) }
  scope :sort_by_location, -> (city) { select("case users.city when '#{city}' then 1 else 2 end as user_city").order("user_city asc") }

  def cover_from_url
    self.cover = open(cover_url)
  end

  def has_photos?
    self.photos.count > 0
  end

  def name
    book.name if book.present?
  end

  def available?
    self.status.normal?
  end

  def book_price
    self.book&.price
  end

  def book_summary
    self.summary || book&.summary
  end

  def book_tags
    self.tags_before_type_cast || book&.tags
  end

  def cover_url
    begin
      self.original_cover || "books/missing_cover.jpg"
    rescue
      "books/missing_cover.jpg"
    end
  end
end
