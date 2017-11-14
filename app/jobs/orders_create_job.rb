class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    @shop = Shop.find_by(shopify_domain: shop_domain)

    @shop.with_shopify_session do
    	puts "this is webhook called----->#{webhook}"
    	puts "this is webhook called----->#{webhook.inspect}"
    end
  end
end
