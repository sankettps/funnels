class AddColumnsToShop < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :is_display_desc, :boolean
    add_column :shops, :redirect_page, :string
  end
end
