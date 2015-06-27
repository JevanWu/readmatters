class User < ActiveRecord::Base
  has_many :orders
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
