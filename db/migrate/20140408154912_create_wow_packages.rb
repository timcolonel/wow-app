class CreateWowPackages < ActiveRecord::Migration
  def change
    create_table :wow_packages do |t|
      t.string :name
      t.text :description
      t.string :homepage
      t.references :user, index: true

      t.timestamps
    end
  end
end
