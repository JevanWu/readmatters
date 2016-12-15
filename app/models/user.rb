class User < ActiveRecord::Base
  has_many :products
  has_many :bought_orders, class_name: "Order", foreign_key: "user_id"
  has_many :sold_orders, class_name: "Order", foreign_key: "seller_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, :styles => {:thumb => "200x200#" }, :default_url => ":style/default_avatar.png", :path => ":class/:attachment/:id_partition/:style/:filename"
    # qiniu server:     :path => ":class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :name, :email, presence: true, on: :create
  validates_format_of :name, with: /[^0-9]+/ , on: :create#/\A[\u4E00-\u9FA5]{1,4}\z/

  def can_buy?(product)
    self != product.user
  end
end
