class Package < ActiveRecord::Base
  belongs_to :user, class_name: User
  has_many :authors, class_name: 'Package::Author', dependent: :destroy

  accepts_nested_attributes_for :authors

  validates_presence_of :name
  validates_presence_of :short_description
  validates_presence_of :description
  validates_presence_of :homepage
  validates_presence_of :user_id

  validates_uniqueness_of :name
  #
  # self.table_name = 'packages'
  # # For package related table(e.g. Package::Version)
  # def self.table_name_prefix
  #   'package_'
  # end
end
