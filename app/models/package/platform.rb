class Package::Platform < ActiveRecord::Base
  belongs_to :parent, class_name: Package::Platform

  validates_presence_of :name


  #Will retrieve the platform name from the file name
  def self.get_from_file(file)
    array = file.original_filename.split('.')
    name = 'all'
    if array.size == 3
      name == array[1]
    end
    platform = Package::Platform.where(name: name).first
    raise Wow::Error, "Unknown platform `#{name}`!" if platform.nil?
    platform
  end

  def to_s
    name
  end
end
