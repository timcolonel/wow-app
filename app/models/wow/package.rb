class Wow::Package < ActiveRecord::Base
  belongs_to :user, :class_name => User

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :homepage
  validates_presence_of :user_id

  validates_uniqueness_of :name

  #Create the package from the yml config file
  #+user+ is the user who created the package
  #The param +config+ is a hash
  def self.create_from_config(user, config)
    package == Wow::Package.new
    package.name = config['name']
    package.description = config['description']
    package.homepage = config['homepage']
    package.user = user
    package.save
  end
end
