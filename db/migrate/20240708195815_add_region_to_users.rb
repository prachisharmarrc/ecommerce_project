class AddRegionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :region, :string
  end
end
