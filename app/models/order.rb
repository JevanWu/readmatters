class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :receiver, class: "User"
  has_many :line_items
  has_one :province
  has_one :city
  has_one :district
end
