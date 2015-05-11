class MoveTagOutOfPackageNamespace < ActiveRecord::Migration
  def change
    rename_table :package_tags, :tags
    rename_table :package_tags_packages, :packages_tags
  end
end
