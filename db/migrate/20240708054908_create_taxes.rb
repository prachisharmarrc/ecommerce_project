class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.string :region
      t.string :tax_type
      t.decimal :tax_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
