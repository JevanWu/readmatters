class User < ActiveRecord::Base
  has_many :orders
  has_many :orders_buying, class: "Order", foreign_key: :receiver_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    if new_record?
      super
    else
      name ||= email.match(/(.+)@/)[1]
      name.titleize
    end
  end
end
