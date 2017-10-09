class ProductsCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)

    @shop = Shop.find_by(shopify_domain: shop_domain)
    # Webhook for Product Filter
    @shop.with_shopify_session do
      @product = webhook
      @product_id = @product['id'].to_s.try(:strip)
      @product_title = @product['title'].try(:strip).try(:html_safe)  
      @product_handle = @product['handle'].try(:strip).try(:html_safe)                     
      @product_type = @product['product_type'].try(:strip).try(:html_safe) 
      @product_vendor = @product['vendor'].try(:strip).try(:html_safe) 
      @product_tags = @product['tags'].try(:strip).try(:html_safe) 
      @published = @product['published_at']

      if @published.present?
      puts "========in create========================="
        @tag_array = []
        @query = @shop.filter_shop_products.find_or_create_by(:product_id => @product_id,:title => @product_title,handle: @product_handle,vendor: @product_vendor,product_type: @product_type,tags: @product_tags)
        @query = @shop.filter_shop_attributes.find_or_create_by(:detail_type => 'type',:detail_value => @product_type)
        @query = @shop.filter_shop_attributes.find_or_create_by(:detail_type => 'vendor',:detail_value => @product_vendor)

        if @product_tags.include? ","
          @tag_array = @product_tags.split(',')
          @tag_array.collect{|x| x.strip || x }
        else
          @tag_array.push(@product_tags)
        end

        @tag_array.each do |tag|
            @query = @shop.filter_shop_attributes.find_or_create_by(:detail_type => 'tag',:detail_value => tag.strip)
        end
      end
    end

  end
end
