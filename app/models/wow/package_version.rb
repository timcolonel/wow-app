class Wow::PackageVersion < ActiveRecord::Base
  belongs_to :package, :class_name => Wow::Package
  belongs_to :platform, :class_name => Wow::PackagePlatform

  validates_presence_of :version
  validates_presence_of :link
  validates_presence_of :package_id
  validates_presence_of :platform_id

  def to_s
    "#{package} #{version}"
  end
end
