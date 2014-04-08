class Wow::Package < ActiveRecord::Base
  belongs_to :user, :class_name => User


  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :homepage
  validates_presence_of :user_id
end
