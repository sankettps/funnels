class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    @shop = Shop.find_by(shopify_domain: shop_domain)

    @shop.with_shopify_session do
    	puts "this is webhook called----->#{webhook}"
    	puts "this is webhook called----->#{webhook.inspect}"
    	cart_token = webhook['cart_token']
    	FunnelReport.where(cart_token: cart_token).each do |report|
    		# webhook['line_items']any? {|h| h[:variant_id] == report.product_id}
    		puts "report found----->#{report.inspect}"
    		line_items = webhook['line_items'].group_by { |x| x["variant_id"] }
				line_item = line_items[report.product_id]
    		puts "line item there----->#{line_item.inspect}"
    		report.update(price: line_item[0]["price"],is_purchased: true) if line_item.present?
    	end
    end
  end
end
