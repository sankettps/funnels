class AddFieldsToShop < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :is_products_cloned, :boolean, :default => false
    add_column :shops, :domain, :string
    add_column :shops, :email, :string
    add_column :shops, :currency_symbol, :string
    add_column :shops, :currency, :string
    add_column :shops, :is_products_clonning, :boolean, default: false
  end
end
