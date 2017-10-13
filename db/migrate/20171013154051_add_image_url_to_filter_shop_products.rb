class AddImageUrlToFilterShopProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :filter_shop_products, :image, :string
  end
end
