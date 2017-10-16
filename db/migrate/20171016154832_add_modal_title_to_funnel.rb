class AddModalTitleToFunnel < ActiveRecord::Migration[5.1]
  def change
    add_column :funnels, :title, :string
  end
end
