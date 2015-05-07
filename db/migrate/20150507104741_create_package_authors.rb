class CreatePackageAuthors < ActiveRecord::Migration
  def change
    create_table :package_authors do |t|
      t.references :package, index: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
