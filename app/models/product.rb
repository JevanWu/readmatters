require 'nokogiri'

class Product < ActiveRecord::Base
  belongs_to :user
  attr_accessor :book_link
  before_save :auto_generate_description

  private
  
    def auto_generate_description
      doc = Nokogiri::HTML(open(self.book_link))
      self.description = doc.css('#link-report .intro').last.content
    end
end
