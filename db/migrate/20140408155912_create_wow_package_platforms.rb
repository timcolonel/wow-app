class CreateWowPackagePlatforms < ActiveRecord::Migration
  def change
    create_table :wow_package_platforms do |t|
      t.string :name
      t.references :parent, index: true

      t.timestamps
    end
  end
end
