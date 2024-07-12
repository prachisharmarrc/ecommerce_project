# app/admin/categories.rb
ActiveAdmin.register Category do
  permit_params :category_name, product_ids: []

  index do
    selectable_column
    id_column
    column :category_name
    column :products do |category|
      category.products.map(&:product_name).join(", ")
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :category_name
      f.input :products, as: :check_boxes, collection: Product.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :category_name
      row :products do |category|
        category.products.map(&:product_name).join(", ")
      end
    end
    active_admin_comments
  end

  # Filter settings
  filter :category_name
  # Remove the following line since it causes the error
  # filter :products, as: :select, collection: -> { Product.all }
end
