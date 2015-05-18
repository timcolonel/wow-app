class CreatePackageVersions < ActiveRecord::Migration
  def change
    create_table :package_versions do |t|
      t.integer :major
      t.integer :minor
      t.integer :patch
      t.integer :stage, default: 3
      t.integer :identifier

      t.timestamps null: false
    end
  end
end
