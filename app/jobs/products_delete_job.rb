class ProductsDeleteJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    @shop = Shop.find_by(shopify_domain: shop_domain)

    @shop.with_shopify_session do
      @product = webhook
      @product_id=@product['id'].to_s
      @pdelete = @shop.filter_shop_products.find_by_product_id(@product_id)
      if @pdelete.present?
        @pdelete.destroy
      end
      puts "========in delete========#{@pdelete}================="
    end
    
  end
end
  