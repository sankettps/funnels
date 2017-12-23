class Funnel < ApplicationRecord
  belongs_to :shop
  has_many :funnel_products, dependent: :destroy # funnel products per funnel
  has_many :filter_shop_product, through: :funnel_products # products per funnel

  has_many :upsell_products, dependent: :destroy # upsell products per funnel
  has_many :upsell_filter_product, through: :upsell_products, source: :filter_shop_product # products per funnel

  has_many :downsell_products, dependent: :destroy # downsell products per funnel
  has_many :downsell_filter_product, through: :downsell_products, source: :filter_shop_product # products per funnel

  has_one :advance_setting, through: :shop
  def upsell_css
  	if is_advance_colors && advance_setting
  		advance_setting.upsell_css
  	else
  		{
  			"buy_bg_color"=>"#398439", 
  			"buy_text_color"=>"#ffffff", 
  			"cancel_bg_color"=>"#d4d4d4", 
  			"title_text_color"=>"#333333", 
  			"cancel_text_color"=>"#333333"
  		}
  	end
  end

  def downsell_css
  	if is_advance_colors && advance_setting
  		advance_setting.downsell_css
  	else
  		{
  			"buy_bg_color"=>"#398439", 
  			"buy_text_color"=>"#ffffff", 
  			"cancel_bg_color"=>"#d4d4d4", 
  			"title_text_color"=>"#333333", 
  			"cancel_text_color"=>"#333333"
  		}
  	end
  end
end
