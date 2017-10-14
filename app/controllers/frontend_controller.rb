class FrontendController < ApplicationController
	include FrontendHelper
	def get_upsell_detail
	 	@shop = Shop.find_by_shopify_domain(params[:shop_id])
	 	if @shop.present?
	 		# @funnel = @shop.funnels.find_by(is_active: true)
	 		@filter_product = FilterShopProduct.find_by(product_id: params[:product_id])
	 		@funnel = @filter_product.funnels.find_by(is_active: true) if @filter_product

	 		@shop_url ="https://#{ShopifyApp.configuration.api_key}:#{@shop.shopify_token}@#{@shop.shopify_domain}/admin/"
    	ShopifyAPI::Base.site = @shop_url
    	if @funnel
		 		@up_product = ShopifyAPI::Product.find(@funnel.up_product_id)
    		@up_variant = @up_product.variants.first
		 		
		 		@down_product = ShopifyAPI::Product.find(@funnel.down_product_id)
    		@down_variant = @down_product.variants.first
		 		puts "<======test product========#{@up_product.inspect}===============>"
		 		modal_html
		 		# @html = modal_html
		 		# @funnel
		 		@response = {data: @html}
		 	else
		 		puts "no funnel=========================="
	 			@response = {data: ''}
		 	end
	 	else
		 		puts "no shop=========================="
	 		@response = {data: ''}
	 	end
	 	render json: @response
		# $.getScript( "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js", function( ) {
  #     $("#test").click(function() {
		# 		console.log(typeof $().modal == 'function')
  #       $('#myModal').modal('show');
		# 	});
  # 	})
	end
end
