class AddDeviseToAdminUsers < ActiveRecord::Migration[6.1]
  def up
    change_table :admin_users do |t|
      t.string :email, null: false, default: "" unless column_exists?(:admin_users, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:admin_users, :encrypted_password)
      t.string :reset_password_token unless column_exists?(:admin_users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:admin_users, :reset_password_sent_at)
      t.datetime :remember_created_at unless column_exists?(:admin_users, :remember_created_at)
      t.integer :sign_in_count, default: 0, null: false unless column_exists?(:admin_users, :sign_in_count)
      t.datetime :current_sign_in_at unless column_exists?(:admin_users, :current_sign_in_at)
      t.datetime :last_sign_in_at unless column_exists?(:admin_users, :last_sign_in_at)
      t.string :current_sign_in_ip unless column_exists?(:admin_users, :current_sign_in_ip)
      t.string :last_sign_in_ip unless column_exists?(:admin_users, :last_sign_in_ip)
    end

    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end

  def down
    change_table :admin_users do |t|
      t.remove :email if column_exists?(:admin_users, :email)
      t.remove :encrypted_password if column_exists?(:admin_users, :encrypted_password)
      t.remove :reset_password_token if column_exists?(:admin_users, :reset_password_token)
      t.remove :reset_password_sent_at if column_exists?(:admin_users, :reset_password_sent_at)
      t.remove :remember_created_at if column_exists?(:admin_users, :remember_created_at)
      t.remove :sign_in_count if column_exists?(:admin_users, :sign_in_count)
      t.remove :current_sign_in_at if column_exists?(:admin_users, :current_sign_in_at)
      t.remove :last_sign_in_at if column_exists?(:admin_users, :last_sign_in_at)
      t.remove :current_sign_in_ip if column_exists?(:admin_users, :current_sign_in_ip)
      t.remove :last_sign_in_ip if column_exists?(:admin_users, :last_sign_in_ip)
    end
  end
end
