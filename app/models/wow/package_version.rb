class Wow::PackageVersion < ActiveRecord::Base
  belongs_to :package, :class_name => Wow::Package
  belongs_to :platform, :class_name => Wow::PackagePlatform

  validates_presence_of :version
  validates_presence_of :link
  validates_presence_of :package_id
  validates_presence_of :platform_id

  validates_uniqueness_of :version, :scope => [:package_id, :platform_id]

  def to_s
    "#{package} #{version}"
  end

  def self.create_from_file(user, file)
    config = parse_config(file)
    puts config
    package = get_package(user, config)
    package_version = Wow::PackageVersion.new
    package_version.version = config['version']
    package_version.package = package
    package_version.platform = Wow::PackagePlatform.get_from_file(file)
    package_version.link = 'tmp'
    raise Wow::Error, package_version.errors.full_messages.to_s unless package_version.valid?
    #Then save the file if everything worked fine
    package_version.link = save_file_local(file)
    package_version.save!
  end

  def self.save_file_local(file)
    name = file.original_filename
    path = File.join(Settings.local_file['directory'], name)
    FileUtils.mkdir_p(Settings.local_file['directory'])
    File.open(path, 'wb') { |f| f.write(file.read) }
  end

  def self.parse_config(file)
    result = {}
    tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(file.tempfile))
    tar_extract.each do |tarentity|
      if tarentity.full_name == 'wow.yml'
        result = YAML.load(tarentity.read)
      end
    end
    tar_extract.close
    result
  end

  def self.get_package(user, config)
    package = Wow::Package.where(:name => config['name']).first
    if package.nil?
      package = Wow::Package.create_from_config(user, config)

    end
    package
  end
end
