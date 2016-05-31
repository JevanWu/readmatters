class User < ActiveRecord::Base
  has_many :products
  has_many :bought_orders, class_name: "Order", foreign_key: "user_id"
  has_many :sold_orders, class_name: "Order", foreign_key: "seller_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :price, presence: true
  has_attached_file :avatar, :styles => {:thumb => "200x200#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def name
    if new_record?
      super
    else
      name ||= email.match(/(.+)@/)[1]
      name.titleize
    end
  end
end
