class CreateFunnels < ActiveRecord::Migration[5.1]
  def change
    create_table :funnels do |t|
      t.string :name
      t.string :up_product_id
      t.string :down_product_id
      t.boolean :is_active
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
