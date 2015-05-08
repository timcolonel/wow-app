class Package::Tag < ActiveRecord::Base
  validates :name, uniqueness: true
end
