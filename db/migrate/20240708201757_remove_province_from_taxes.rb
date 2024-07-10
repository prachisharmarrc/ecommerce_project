class RemoveProvinceFromTaxes < ActiveRecord::Migration[7.1]
  def change
    remove_column :taxes, :province, :string
  end
end
