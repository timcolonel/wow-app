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

  def self.create_from_file(user, file)
    config = parse_config(file)
    package = Wow::Package.where(:name => config['name'])
    if package.nil?
      package = Wow::Package.create_from_config(user, config)
    end
    save_file_local(file)
  end

  def self.save_file_local(file)
    name = file.original_filename
    path = File.join(Settings.local_file['directory'], name)
    FileUtils.mkdir_p(Settings.local_file['directory'])
    File.open(path, 'wb') { |f| f.write(file.read) }
  end

  def parse_config(file)
    result = {}
    tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(file.tempfile))
    tar_extract.each do |filename|
      if filename == 'wow.yml'
        result = YAML.load(file.read)
      end
    end
    tar_extract.close
    result
  end
end
