class CreateDownsellProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :downsell_products do |t|
      t.references :funnel, foreign_key: true
      t.references :filter_shop_product, foreign_key: true

      t.timestamps
    end
  end
end
