class ShopUninstallJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
  	puts webhook.inspect
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
    	shop.filter_shop_attributes.destroy_all
    	shop.filter_shop_products.destroy_all
    	Offer.where(store_id: shop.uuid).destroy_all
    	shop.update_attributes(is_deleted: true,is_products_cloned: false,is_products_clonning: false)

    	# install / uninstall track in mautic
    	url = URI("https://e.hulkcode.com/mautic-contacts/shopifyapp.php")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Post.new(url)
		request["content-type"] = 'application/json'
		request["cache-control"] = 'no-cache'
		request.body = '{"name": "'+webhook['name']+'","email": "'+webhook['email']+'","address1": "'+webhook['address1']+'","city": "'+webhook['city']+'","country": "'+webhook['country_name']+'","province": "'+webhook['province']+'","zip": "'+webhook['zip']+'","phone": "'+webhook['phone']+'","appcode": "volumediscount","status": "uninstall"}'

		response = http.request(request)
    end
  end
end
