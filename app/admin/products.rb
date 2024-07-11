# app/admin/products.rb
ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :image, category_ids: []

  index do
    selectable_column
    id_column
    column :product_name
    column :description
    column :price
    column :stock_quantity
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "100x100"
      end
    end
    column :categories do |product|
      product.categories.map(&:category_name).join(", ")
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :product_name
      row :description
      row :price
      row :stock_quantity
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "300x300"
        end
      end
      row :categories do |product|
        product.categories.map(&:category_name).join(", ")
      end
    end
    active_admin_comments
  end

  filter :product_name
  filter :description
  filter :price
  filter :stock_quantity
  filter :categories, as: :select, collection: Category.all.map { |category| [category.category_name, category.id] }

end
