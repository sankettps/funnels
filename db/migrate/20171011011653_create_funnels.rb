class CreateFunnels < ActiveRecord::Migration[5.1]
  def change
    enable_extension "hstore"
    create_table :funnels do |t|
      t.string :name
      t.string :up_sell_title
      t.string :down_sell_title
      t.integer :down_sell_time_out
      t.integer :down_sell_interval
      t.boolean :is_display_desc
      t.boolean :is_skip_cart
      t.boolean :is_active
      t.boolean :is_advance_colors
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
