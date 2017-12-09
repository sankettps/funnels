class CreateAdvanceSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :advance_settings do |t|
      t.hstore :downsell_css
      t.hstore :upsell_css
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
