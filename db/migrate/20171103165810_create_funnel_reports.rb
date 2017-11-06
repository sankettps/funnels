class CreateFunnelReports < ActiveRecord::Migration[5.1]
  def change
    create_table :funnel_reports do |t|
      t.string :product_id
      t.string :up_product_id
      t.string :down_product_id
      t.string :hf_action
      t.float :price
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
