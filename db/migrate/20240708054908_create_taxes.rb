class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.string :region
      t.string :tax_type
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
