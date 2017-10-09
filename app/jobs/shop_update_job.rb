class ShopUpdateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    @shop = Shop.find_by(shopify_domain: shop_domain)
    @shop.with_shopify_session do
    	currency_symbol = ISO4217::Currency.from_code(webhook['currency']).symbol
    	@shop.update(email: webhook['email'],domain: webhook['domain'],currency_symbol: currency_symbol,currency: webhook['currency'])
    end
  end
end
