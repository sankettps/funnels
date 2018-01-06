class ShopUninstallJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
  	puts webhook.inspect
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
    	shop.filter_shop_attributes.destroy_all
    	shop.filter_shop_products.destroy_all
    	shop.update_attributes(is_products_cloned: false,is_products_clonning: false)
    end
  end
end
