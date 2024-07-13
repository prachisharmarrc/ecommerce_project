# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params :user_id, :status, :address, :city, :province_id, :postal_code, order_items_attributes: [:product_id, :quantity, :price], order_taxes_attributes: [:tax_id, :tax_amount]

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :address
    column :city
    column :province
    column :postal_code
    column :total_price
    column :created_at
    actions do |order|
      item "View Details", admin_order_path(order)
    end
  end

  show do
    attributes_table do
      row :user
      row :status
      row :address
      row :city
      row :province
      row :postal_code
      row :total_price
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column "Product" do |order_item|
          order_item.product.product_name
        end
        column :quantity
        column :price
        column "Total" do |order_item|
          number_to_currency order_item.quantity * order_item.price
        end
      end
    end

    panel "Taxes" do
      table_for order.order_taxes do
        column "Tax Type" do |order_tax|
          order_tax.tax.tax_type
        end
        column "Tax Amount" do |order_tax|
          number_to_currency order_tax.tax_amount
        end
      end
    end

    panel "Order Summary" do
      attributes_table_for order do
        row "Subtotal" do
          number_to_currency order.total_price
        end
        row "Total Taxes" do
          number_to_currency order.total_taxes
        end
        row "Grand Total" do
          number_to_currency order.total_amount
        end
      end
    end

    active_admin_comments
  end

  filter :user
  filter :status
  filter :address
  filter :city
  filter :province
  filter :postal_code
  filter :total_price
  filter :created_at
end
