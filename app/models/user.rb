class User < ActiveRecord::Base
  extend Enumerize
  has_many :products
  has_many :bought_orders, class_name: "Order", foreign_key: "user_id"
  has_many :sold_orders, class_name: "Order", foreign_key: "seller_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enumerize :current_location, in: [:shanghai, :hangzhou, :chengdu, :shenzhen, :beijing]

  has_attached_file :avatar, :styles => {:thumb => "260x260#" },
                             :default_url => "default_image.png",
                             :path => Figaro.env.paperclip_storage_path,
                             :url => Figaro.env.paperclip_storage_url
    # qiniu server:     :path => ":class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :email, presence: true, on: :create
  validates :name, :current_location, :phone, presence: true, on: :more_info
  validates_format_of :name, with: /[^0-9]+/, on: :more_info #/\A[\u4E00-\u9FA5]{1,4}\z/

  def can_buy?(product)
    self != product.user
  end
end
