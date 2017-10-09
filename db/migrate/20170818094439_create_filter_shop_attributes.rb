class CreateFilterShopAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :filter_shop_attributes do |t|
      t.references :shop, foreign_key: true
      t.string :detail_type
      t.string :detail_value

      t.timestamps
    end
  end
end
