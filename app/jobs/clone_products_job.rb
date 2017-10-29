class CloneProductsJob < ApplicationJob
  queue_as :default

  def perform(shop)
  	shop.update(is_products_clonning: true)
		@shop_url ="https://#{ShopifyApp.configuration.api_key}:#{shop.shopify_token}@#{shop.shopify_domain}/admin/"
		# @shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
		ShopifyAPI::Base.site = @shop_url
		puts "inside job"
		puts"<==================inside job============#{@shop_url}==============>"
		@products_count=ShopifyAPI::Product.count
		puts "<========products_count===#{@products_count}=============>"
		@total_pages=(@products_count.to_f/250).ceil
		@last_page_product_count=(250-(@total_pages*250-@products_count))

		for @page_no in 1..@total_pages
			@product_count=0
			puts "Page Number = #{@page_no}"
			@products = ShopifyAPI::Product.find(:all, :params => {:limit => 250,:page => @page_no})
			puts @page_no
			if @products.present?  #review
				@products.each do |product|
					@product_count += 1 

					@product_id = product.id.to_s.try(:strip)
					@product_title = product.title.to_s.try(:strip).try(:html_safe) 
					@product_handle = product.handle.to_s.try(:strip).try(:html_safe)                    
					@product_type = product.product_type.to_s.try(:strip).try(:html_safe)
					@product_vendor = product.vendor.to_s.try(:strip).try(:html_safe)
					@product_tags = product.tags.to_s.try(:strip).try(:html_safe)
					@published = product.published_at
     			if @published.present?
					
						@tag_array = []

						@query = shop.filter_shop_products.find_or_create_by(:product_id => @product_id,:title => @product_title,handle: @product_handle,vendor: @product_vendor,product_type: @product_type,tags: @product_tags,image: product.image.try(:src))

						@query = shop.filter_shop_attributes.find_or_create_by(:detail_type => 'type',:detail_value => @product_type)

						@query = shop.filter_shop_attributes.find_or_create_by(:detail_type => 'vendor',:detail_value => @product_vendor)

						if @product_tags.include? ","
							@tag_array = @product_tags.split(',')
							@tag_array.collect{|x| x.try(:strip) || x }
						else
							@tag_array.push(@product_tags.try(:strip))
						end

						@tag_array.each do |tag|
								@query = shop.filter_shop_attributes.find_or_create_by(:detail_type => 'tag',:detail_value => tag.strip)
						end
						puts "<===@page_no=#{@page_no}====@total_pages=#{@total_pages}====@product_count=#{@product_count}====@last_page_product_count==#{@last_page_product_count}=>" 
						if((@page_no==@total_pages) && @product_count==@last_page_product_count)
							shop.update_attributes(:is_products_cloned => true,is_products_clonning: false)
							puts "<===============================complete=========================>"
						end
					end
				end
			end
		end
	end
end
