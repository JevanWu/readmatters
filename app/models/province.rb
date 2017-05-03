class Province < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities
  has_one :order
end
