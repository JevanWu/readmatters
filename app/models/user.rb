class User < ApplicationRecord
  extend Enumerize
  has_many :products
  has_many :bought_orders, class_name: "Order", foreign_key: "user_id"
  has_many :sold_orders, class_name: "Order", foreign_key: "seller_id"
  has_many :messages
  has_many :orders
  has_one :cart

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # enumerize :current_location, in: [:beijing, :shanghai, :shenzhen, :guangzhou, :hangzhou, :chengdu]

  has_attached_file :avatar, :styles => {:original => "260x260#" },
                             :default_url => "default_image.png",
                             :path => Figaro.env.paperclip_storage_path,
                             :url => Figaro.env.paperclip_storage_url
    # qiniu server:     :path => ":class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_save :set_personal_link

  validates :email, presence: true, on: :create
  validates :name, :province, :city, :district, :phone, presence: true, on: :more_info
  validates_format_of :name, with: /[^0-9]+/, on: :more_info #/\A[\u4E00-\u9FA5]{1,4}\z/
  validates_format_of :phone, with: /\A[0-9]{11}\z/, on: :more_info

  def conversations
    Conversation.where("sender_id = :user_id or recipient_id = :user_id", user_id: self.id)
  end

  def can_buy?(product)
    self != product.user
  end

  def unread_message_count
    Message.where(conversation_id: self.conversations.pluck(:id), read_at: nil).where.not(user_id: self.id).count
  end

  def read_message(conversation)
    sender = conversation.opposed_user(self)
    conversation.messages.where(user: sender).update_all(read_at: Time.current)
  end

  def should_take_survey?
    self.products.count <= 1
  end

  def set_personal_link
    if self.name.present? && self.personal_link.blank?
      link = Pinyin.t(self.name, splitter: '-')&.downcase
      index = 0
      final_link = link
      loop do
        break if !User.exists?(personal_link: final_link)
        index += 1
        final_link = "#{link}-%02d" % [index]
      end
      self.personal_link = final_link
    end
  end

  #TODO delete all deprecated current_location related code
  def current_city_text
    city = ChinaCity.get(self.city)
    city = ChinaCity.get(self.province) if %w(市辖区 县).include?(city)
    city
  end

  # def to_param
  #   personal_link
  # end
end
