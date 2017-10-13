class HomeController < ShopifyApp::AuthenticatedController
# class HomeController < ApplicationController
  def index
    # @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    # @webhooks = ShopifyAPI::Webhook.find(:all)
  end

  def filter
 #  	@shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
	# ShopifyAPI::Base.site = @shop_url
    @store_id = ShopifyAPI::Shop.current.myshopify_domain 
    @store = Shop.find_by_shopify_domain(@store_id)
    @store = Shop.first
    @store_id = Shop.first.shopify_domain
    @currency_symbol = @store.currency_symbol
    @currency = @store.currency
    @shop_url="https://#{@store_id}/admin/products/"
    @collection_array=[]
    @products = @store.filter_shop_products
    @product_attributes = @store.filter_shop_attributes
    @product_titles = @products.collect(&:title).join(",")
    puts "=========================================Titles=============================="
    puts @product_titles
    @product_types = @product_attributes.where(detail_type: 'type').collect(&:detail_value).join(",")
    @product_vendors = @product_attributes.where(detail_type: 'vendor').collect(&:detail_value).join(",")
    @product_tags = @product_attributes.where(detail_type: 'tag').collect(&:detail_value).join(",")
    @product_custom_collections=ShopifyAPI::CustomCollection.find(:all).collect(&:title).join(",")
    @product_smart_collections=ShopifyAPI::SmartCollection.find(:all).collect(&:title).join(",")
  end
end
