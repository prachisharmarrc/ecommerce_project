# app/admin/customers_orders.rb
ActiveAdmin.register_page "CustomersOrders" do
    menu label: "Customers and Orders"
  
    content title: "Customers and Orders" do
      panel "Customers with Orders" do
        table_for User.includes(orders: [:order_items, :products, :order_taxes, :taxes]).where.not(orders: { id: nil }) do
          column "Customer Email" do |user|
            user.email
          end
          column "Orders" do |user|
            table_for user.orders do
              column("Order ID") { |order| link_to order.id, admin_order_path(order.id) }
              column "Date", :created_at
              column "Products" do |order|
                order.products.map(&:product_name).join(", ")
              end
              column "Subtotal" do |order|
                number_to_currency(order.total_price)
              end
              column "Taxes" do |order|
                order.order_taxes.map do |order_tax|
                  "#{order_tax.tax.tax_type} (#{order_tax.tax.region}): #{number_to_currency(order_tax.tax_amount)}"
                end.join("<br>").html_safe
              end
              column "Total" do |order|
                number_to_currency(order.total_amount)
              end
            end
          end
        end
      end
    end
  end
  