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

  def authors=(authors)
    return if authors.nil?
    ids = []
    authors.each do |author_hash|
      if author_hash.is_a? Package::Author
        author = author_hash
      else
        author = Package::Author.new(author_hash.permit(:id, :name, :email))
      end
      if author.id.nil?
        self.authors << author
      else
        existing = self.authors.find_by_id(author.id)
        existing.name = author.name
        existing.email = author.email
        ids << author.id
      end
    end
    self.authors.where.not(id: ids).destroy_all
  end
end
