class Package::Author < ActiveRecord::Base
  belongs_to :package, class_name: 'Package'
end
