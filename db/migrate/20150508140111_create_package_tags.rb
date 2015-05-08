class CreatePackageTags < ActiveRecord::Migration
  def change
    create_table :package_tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :package_tags_packages do |t|
      t.references :package
      t.references :tag
      t.timestamps
    end
  end
end
