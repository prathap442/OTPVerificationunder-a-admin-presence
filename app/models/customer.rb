require 'httparty'
class Customer < ApplicationRecord
  belongs_to :user  
  validates_presence_of :first_name,:last_name,:mobile
  validates_uniqueness_of :mobile  
end
