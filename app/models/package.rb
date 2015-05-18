class Package < ActiveRecord::Base
  belongs_to :user, class_name: User
  has_many :authors, class_name: 'Package::Author', dependent: :destroy

  has_and_belongs_to_many :tags, class_name: 'Tag'

  accepts_nested_attributes_for :authors

  validates_presence_of :name
  validates_presence_of :short_description
  validates_presence_of :description
  validates_presence_of :homepage
  validates_presence_of :user_id

  validates_uniqueness_of :name
  #
  # self.table_name = 'packages'
  # # For package related table(e.g. Package::Release)
  # def self.table_name_prefix
  #   'package_'
  # end

  def authors=(authors)
    return if authors.nil?
    self.authors.destroy_all
    authors.each do |author_hash|
      if author_hash.is_a? Package::Author
        author = author_hash
      else
        author = Package::Author.new(author_hash.permit(:id, :name, :email))
      end
      self.authors << author
    end
  end

  def tags=(tags)
    return if tags.nil?
    association(:tags).writer([])
    tags.each do |tag_name|
      if tag_name.is_a? Package::Tag
        tag = tag_name
      else
        tag = Package::Tag.find_or_create_by(name: tag_name)
      end
      self.tags << tag
    end
  end
end
