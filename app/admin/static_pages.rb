# app/admin/static_pages.rb
ActiveAdmin.register StaticPage do
    permit_params :title, :content
  
    form do |f|
      f.inputs do
        f.input :title, input_html: { readonly: true }
        f.input :content
      end
      f.actions
    end
  
    index do
      selectable_column
      id_column
      column :title
      column :content
      actions
    end
  
    show do
      attributes_table do
        row :title
        row :content
      end
      active_admin_comments
    end
  end
  