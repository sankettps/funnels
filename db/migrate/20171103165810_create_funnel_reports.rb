class CreateFunnelReports < ActiveRecord::Migration[5.1]
  def change
    create_table :funnel_reports do |t|
      t.string :product_id
      t.string :hf_type
      t.string :cart_token
      t.float :price
      t.boolean :is_purchased
      t.datetime :temp_date
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
