class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :filter_shop_attributes, dependent: :destroy # shops tags/vendors/types
  has_many :filter_shop_products, dependent: :destroy # products of shop from shopify 
  has_many :funnels, dependent: :destroy # funnels of shops 
  after_create :set_configuration
  after_update :set_configuration, if: ->(obj){ obj.shopify_token_changed? }
  def set_configuration
    # add_display
    @shop_url ="https://#{ShopifyApp.configuration.api_key}:#{self.shopify_token}@#{self.shopify_domain}/admin/"
    ShopifyAPI::Base.site = @shop_url
    @theme = ShopifyAPI::Theme.find(:all).where(role: 'main').first
    @asset = ShopifyAPI::Asset.find('layout/theme.liquid', :params => { :theme_id => @theme.id})
    @asset_value = @asset.value
    @asset.update_attributes(value: @asset_value.gsub('</body>',"<div id='hfUpsell'></div></body>")) unless @asset_value.include?("<div id='hfUpsell'>")

    @asset = ShopifyAPI::Asset.create(:key => 'assets/hf_common.js', value: '
	    
	    jQuery(\'form[action="/cart/add"]\').submit(function(e) {
		    e.preventDefault();
		    $(".funnel-popup").trigger("click");
		  });       
    ', :theme_id => @theme.id)

  end
end
