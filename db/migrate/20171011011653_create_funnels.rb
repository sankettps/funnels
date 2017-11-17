class CreateFunnels < ActiveRecord::Migration[5.1]
  def change
    enable_extension "hstore"
    create_table :funnels do |t|
      t.string :name
      t.string :up_sell_title
      t.string :down_sell_title
      t.hstore :downsell_css
      t.hstore :upsell_css
      t.integer :down_sell_time_out
      t.integer :down_sell_interval
      t.boolean :is_display_desc
      t.string  :redirect_page
      t.boolean :is_active
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
