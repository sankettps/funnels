class AddColumnsToFunnel < ActiveRecord::Migration[5.1]
  def change
    add_column :funnels, :is_display_desc, :boolean
    add_column :funnels, :redirect_page, :string
  end
end
