class ShopController < ApplicationController
  protect_from_forgery with: :null_session

  def filter_products
    @store_id=params[:store_id]
    @store = Shop.find_by_shopify_domain(@store_id)
    # @shopify_token=@store.shopify_token
    shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
    # shop_url = "https://#{ShopifyApp.configuration.api_key}:#{@shopify_token}@#{@store_id}/admin"
    ShopifyAPI::Base.site = shop_url
    @and_or=params[:and_or]
    @filter_data = params[:filter_data].to_s
    @res=JSON.parse(@filter_data)
    @qa=[]
    @query = "shop_id = '#{@store.id}' AND "   

    #Custom Collection
    @collections=ShopifyAPI::CustomCollection.find(:all)
    @collection_array = Hash.new()
    @collections.each do |collection|
        @collection_id=collection.id
        @collection_title=collection.title
        @collection_array[@collection_title]=@collection_id
    end
    #Smart Collection
    @collections=ShopifyAPI::SmartCollection.find(:all)
    @smart_collection_array = Hash.new()
    @collections.each do |collection|
        @collection_id=collection.id
        @collection_title=collection.title
        @smart_collection_array[@collection_title]=@collection_id
    end
    @all_products_array = []
    @products_array = []
    @res.each do |res| 
        @filter_name = res[0]
        @filter_condition = res[1]
        
        if @filter_name=='product_custom_collections' || @filter_name=='product_smart_collections'
            @filter_val = res[2]
        else
            @filter_val = res[2].downcase
        end

        if @filter_condition=='equal'
          @filter_val = ActiveRecord::Base.connection.quote(@filter_val)
            @val=" = #{@filter_val}"
        elsif @filter_condition=='not-equal'
          @filter_val = ActiveRecord::Base.connection.quote(@filter_val)
            @val=" != #{@filter_val}"
        elsif @filter_condition=='contain'
          @filter_val = ActiveRecord::Base.connection.quote("%#{@filter_val}%")
            @val = " LIKE #{@filter_val}"
        elsif @filter_condition=='not-contain'
            @filter_condition='NOT LIKE'
            @filter_val = ActiveRecord::Base.connection.quote("%#{@filter_val}%")
            @val = " NOT LIKE #{@filter_val}"
        elsif @filter_condition=='start-with'
            @filter_condition='LIKE'
            @filter_val = ActiveRecord::Base.connection.quote("#{@filter_val}%")
            @val = " LIKE #{@filter_val}"
        elsif @filter_condition=='end-with'
            @filter_condition='LIKE' 
            @filter_val = ActiveRecord::Base.connection.quote("%#{@filter_val}")
            @val = " LIKE #{@filter_val}"
        end   

        if @filter_name=='product_titles'
            @qa.push("lower(title)#{@val}")
        elsif  @filter_name=='product_vendors'
            @qa.push("lower(vendor)#{@val}")
        elsif  @filter_name=='product_types'
            @qa.push("lower(product_type)#{@val}")
        elsif  @filter_name=='product_tags'
            @qa.push("lower(tags)#{@val}")
        elsif  @filter_name=='product_custom_collections'
          @ccollection_array=[]
            if @filter_condition=='not-equal'
              if(@collection_array.has_key? @filter_val)
                @collection_array.delete(@filter_val)
                @collection_array.each do |key,val|
                  @count=0
              @count1=1
              @page=0
              while @count1 > 0  do
                @page+=1
                @products=ShopifyAPI::Product.find(:all, :params => {:limit => 250,:page => @page,:collection_id =>val})
                @count1=@products.count
                @count+=@count1
                @products.each do |product| 
                  @id=product.id
                      @title=product.title
                      @aa=[@id,@title]
                      @ccollection_array.push(@aa)
                end
              end
                end
                @all_products_array.push(@ccollection_array)
              end
            else

          @collection_idd=@collection_array[res[2]]
              @count=0
              @count1=1
              @page=0
              while @count1 > 0  do
                @page+=1
                @products=ShopifyAPI::Product.find(:all, :params => {:limit => 250,:page => @page,:collection_id =>@collection_idd})
                @count1=@products.count
                @count+=@count1
                @products.each do |product| 
                  @id=product.id
                  @title=product.title
              @aa=[@id,@title]
                  @ccollection_array.push(@aa)  
                end
              end
              @all_products_array.push(@ccollection_array) 
            end
        elsif  @filter_name=='product_smart_collections'
          @scollection_array=[]
          if @filter_condition=='not-equal'
            if(@smart_collection_array.has_key? @filter_val)
              @scollection_array=[]
              @smart_collection_array.delete(@filter_val)
              @smart_collection_array.each do |key,val|
                @count=0
                @count1=1
                @page=0
                while @count1 > 0  do
                  @page+=1
                  @products=ShopifyAPI::Product.find(:all, :params => {:limit => 250,:page => @page,:collection_id =>val})
                  @count1=@products.count
                  @count+=@count1
                  @products.each do |product| 
                    @id=product.id
                        @title=product.title
                        @aa=[@id,@title]
                        @scollection_array.push(@aa)
                  end
                end
              end
              @all_products_array.push(@scollection_array)
            end
          else
            @collection_idd=@smart_collection_array[res[2]]
                @count=0
                @count1=1
                @page=0
                while @count1 > 0  do
                  @page+=1
                  @products=ShopifyAPI::Product.find(:all, :params => {:limit => 250,:page => @page,:collection_id =>@collection_idd})
                  @count1=@products.count
                  @count+=@count1
                  @products.each do |product| 
                    @id=product.id
                    @title=product.title
                @aa=[@id,@title]
                    @scollection_array.push(@aa)
                  end
                end
                @all_products_array.push(@scollection_array)
              end
          end
    end 
    @qa=@qa.join(" #{@and_or} ")
    if @qa.present?
        @query="#{@query}#{@qa}"
        @products = @store.filter_shop_products.where(@query)
        # @products=FilterShopProduct.where(@query)
        @products.each do |product| 
              @id=product.product_id.to_i
              @title=product.title
              @aa=[@id,@title]
              @products_array.push(@aa)
          end
          @all_products_array.push(@products_array)
    end
    @count=0
    @result=[]
    @all_products_array.each do |val|
      @count=@count+1
      if @count==1
        @result=val
        @count+=1
      else
        if @and_or=='OR'
          @result = @result | val
        else
          @result = @result & val
        end
      end
    end
    @table_html=''
    @result.each do |product|
      @p_id=product[0]
      @p_title=product[1]
      @shop_url="https://#{@store_id}/admin/products/#{@p_id}"
      @html="<tr class='single_product #{@p_id}'><td>#{@p_id}</td><td><input type='checkbox' id='p_#{@p_id}' class='select_product'><label for='p_#{@p_id}'><span></span></label></td><td data-pid='#{@p_id}' data-ptitle='#{@p_title}' class='product_data'>#{@p_title}</td><td><a href='#{@shop_url}'' target='_blank'><button type='button' class='btn btn-small btn-inverse'>View in Store</button></a></td></tr>"
      @table_html = @table_html + @html
    end 
    render plain: @table_html
  end

  def get_all_products
    @store_id=params[:store_id]
    @store = Shop.find_by_shopify_domain(@store_id)
    @products = @store.filter_shop_products
    # @products=FilterShopProduct.where(shop_id: @store_id)
    @table_html=''
    if !@products.blank?
      @products.each do |product|
        @p_id=product['product_id']
        @p_title=product['title']
        @shop_url="https://#{@store_id}/admin/products/#{@p_id}"
        @html="<tr class='single_product #{@p_id}'><td>#{@p_id}</td><td><input type='checkbox' id='p_#{@p_id}' class='select_product'><label for='p_#{@p_id}'><span></span></label></td><td data-pid='#{@p_id}' data-ptitle='#{@p_title}' class='product_data'>#{@p_title}</td><td><a href='#{@shop_url}'' target='_blank'><button type='button' class='btn btn-small btn-inverse'>View in Store</button></a></td></tr>"
        @table_html = @table_html + @html
      end 
    end
    render plain: @table_html  
  end

  def is_product_synced
    @shop = Shop.find_by_shopify_domain(params[:store_id])
    render plain: @shop.is_products_cloned.to_s
  end

  def is_installed
    @shop = Shop.find_by_shopify_domain(params[:store_id])
    is_installed = @shop.present? ? !@shop.is_deleted : false
    render plain: is_installed.to_s
  end
end