# coding: utf-8
class District < ActiveRecord::Base
  belongs_to :city
  has_one :province, through: :city
  has_one :order

  def short_name
    @short_name ||= name.gsub(/区|县|市|自治县/,'')
  end

  def brothers
    @brothers ||= District.where("city_id = #{city_id}")
  end

end
