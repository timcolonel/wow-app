class Wow::PackagePlatform < ActiveRecord::Base
  belongs_to :parent, :class_name => Wow::PackagePlatform

  validates_presence_of :name
  def to_s
    name
  end
end
