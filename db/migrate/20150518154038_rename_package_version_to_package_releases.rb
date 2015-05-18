class RenamePackageVersionToPackageReleases < ActiveRecord::Migration
  def change
    remove_index :package_versions, :package_id
    remove_index :package_versions, :platform_id
    rename_table :package_versions, :package_releases
    add_index :package_releases, :package_id
    add_index :package_releases, :platform_id
  end
end
