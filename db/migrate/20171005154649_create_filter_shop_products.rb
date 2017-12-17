class CreateFilterShopProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :filter_shop_products do |t|
      t.references :shop, foreign_key: true
      t.string :product_id
      t.string :title
      t.string :handle
      t.string :vendor
      t.string :product_type
      t.string :image
      t.text :tags

      t.timestamps
    end
  end
end
