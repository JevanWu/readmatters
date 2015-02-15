# coding: utf-8
class City < ActiveRecord::Base
  belongs_to :province
  has_many :districts, dependent: :destroy
  has_one :order

  def short_name
    @short_name ||= name.gsub(/市|自治州|地区|特别行政区/,'')
  end

  def brothers
    @brothers ||= City.where("province_id = #{province_id}")
  end

end
