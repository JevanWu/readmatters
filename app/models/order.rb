class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_one :province
  has_one :city
  has_one :district
end
