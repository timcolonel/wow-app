class CreateWowPackageVersions < ActiveRecord::Migration
  def change
    create_table :package_versions do |t|
      t.string :version
      t.references :package, index: true
      t.references :platform, index: true
      t.string :link

      t.timestamps
    end
  end
end
