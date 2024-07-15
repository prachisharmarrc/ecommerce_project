class AddTrackableToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists? :admin_users, :sign_in_count
      add_column :admin_users, :sign_in_count, :integer, default: 0, null: false
    end
    unless column_exists? :admin_users, :current_sign_in_at
      add_column :admin_users, :current_sign_in_at, :datetime
    end
    unless column_exists? :admin_users, :last_sign_in_at
      add_column :admin_users, :last_sign_in_at, :datetime
    end
    unless column_exists? :admin_users, :current_sign_in_ip
      add_column :admin_users, :current_sign_in_ip, :string
    end
    unless column_exists? :admin_users, :last_sign_in_ip
      add_column :admin_users, :last_sign_in_ip, :string
    end
  end
end
