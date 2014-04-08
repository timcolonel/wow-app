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


  def self.create_from_file(file)
    save_file(file)
  end

  def self.save_file(file)
    save_file_local(file)
  end

  def self.save_file_local(file)
    name = file.original_filename
    path = File.join(Settings.local_file['directory'], name)
    FileUtils.mkdir_p(Settings.local_file['directory'])
    File.open(path, 'w') { |f| f.write(file.read) }
  end
end
