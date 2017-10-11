# class DashboardController < ShopifyApp::AuthenticatedController
class DashboardController < ApplicationController
	before_action :set_current_shop
	def dashboard
		# check_shop_details
		#start cloning products of shop if not clonned
  	CloneProductsJob.perform_later @shop unless @shop.is_products_cloned || @shop.is_products_clonning
	end

	def product_sync_status
		@sync_status = @shop.is_products_cloned ? 'synced' : 'unsynced'
    render plain: @sync_status
	end

	private
		def set_current_shop
			# @current_shop = ShopifyAPI::Shop.current
  	# 	@shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
  	@shop = Shop.first
		end

		# add detail of shop only if not exist
	  def check_shop_details
	  	unless @shop.domain.present?  && @shop.email.present? && @shop.currency_symbol.present? && @shop.currency.present?
    		currency_symbol = ISO4217::Currency.from_code(@current_shop.currency).symbol
	  		@shop.update(email: @current_shop.email,domain: @current_shop.domain,currency_symbol: currency_symbol,currency: @current_shop.currency)
	  	end
	  end
end
