class FunnelsController < ShopifyApp::AuthenticatedController
# class FunnelsController < ApplicationController
  before_action :set_current_shop
  before_action :set_funnel, only: [:show, :edit, :update, :destroy, :change_status]

  # GET /funnels
  # GET /funnels.json
  def index
    @funnels = Funnel.all
  end

  # GET /funnels/1
  # GET /funnels/1.json
  def show
  end

  # GET /funnels/new
  def new
    @funnel = Funnel.new
    # @shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
    # ShopifyAPI::Base.site = @shop_url
    @store_id = @current_shop.myshopify_domain 
    @currency_symbol = @shop.currency_symbol
    @currency = @shop.currency
    @shop_url="https://#{@store_id}/admin/products/"
    @collection_array=[]
    @products = @shop.filter_shop_products
    @product_attributes = @shop.filter_shop_attributes
    @product_titles = @products.collect(&:title).join(",")
    @product_types = @product_attributes.where(detail_type: 'type').collect(&:detail_value).join(",")
    @product_vendors = @product_attributes.where(detail_type: 'vendor').collect(&:detail_value).join(",")
    @product_tags = @product_attributes.where(detail_type: 'tag').collect(&:detail_value).join(",")
    @product_custom_collections=ShopifyAPI::CustomCollection.find(:all).collect(&:title).join(",")
    @product_smart_collections=ShopifyAPI::SmartCollection.find(:all).collect(&:title).join(",")
  end

  # GET /funnels/1/edit
  def edit
    @funnel = Funnel.find(params[:id])
    @funnel_products = @funnel.funnel_products.collect(&:filter_shop_product_id)
    @selected_products_html = ''
    @funnel_products.each do |pid|
      @product = FilterShopProduct.find(pid)
      if @product.present? 
        @pid = @product.product_id
        @selected_products_html = @selected_products_html + "<tr class='single_product #{@pid}''><td><img src='#{@product.image}'' width='30' height='30'></td><td data-pid='#{@pid}' data-ptitle='#{@product.title}' class='product_data'>#{@product.title}</td><td><button type='button' class='btn btn-small btn-danger remove-product'>Remove</button></td></tr>"
      end
    end

    @funnel_upsell_products = @funnel.upsell_products.collect(&:filter_shop_product_id)
    @selected_upsell_products_html = ''
    @funnel_upsell_products.each do |pid|
      @product = FilterShopProduct.find(pid)
      if @product.present? 
        @pid = @product.product_id
        @selected_upsell_products_html = @selected_upsell_products_html + "<tr class='single_product #{@pid}''><td><img src='#{@product.image}'' width='30' height='30'></td><td data-pid='#{@pid}' data-ptitle='#{@product.title}' class='product_data'>#{@product.title}</td><td><button type='button' class='btn btn-small btn-danger remove-product'>Remove</button></td></tr>"
      end
    end

    @funnel_downsell_products = @funnel.downsell_products.collect(&:filter_shop_product_id)
    @selected_downsell_products_html = ''
    @funnel_downsell_products.each do |pid|
      @product = FilterShopProduct.find(pid)
      if @product.present? 
        @pid = @product.product_id
        @selected_downsell_products_html = @selected_downsell_products_html + "<tr class='single_product #{@pid}''><td><img src='#{@product.image}'' width='30' height='30'></td><td data-pid='#{@pid}' data-ptitle='#{@product.title}' class='product_data'>#{@product.title}</td><td><button type='button' class='btn btn-small btn-danger remove-product'>Remove</button></td></tr>"
      end
    end

    @store_id = @current_shop.myshopify_domain 
    @currency_symbol = @shop.currency_symbol
    @currency = @shop.currency
    @shop_url="https://#{@store_id}/admin/products/"
    @collection_array=[]
    @products = @shop.filter_shop_products
    @product_attributes = @shop.filter_shop_attributes
    @product_titles = @products.collect(&:title).join(",")
    @product_types = @product_attributes.where(detail_type: 'type').collect(&:detail_value).join(",")
    @product_vendors = @product_attributes.where(detail_type: 'vendor').collect(&:detail_value).join(",")
    @product_tags = @product_attributes.where(detail_type: 'tag').collect(&:detail_value).join(",")
    @product_custom_collections=ShopifyAPI::CustomCollection.find(:all).collect(&:title).join(",")
    @product_smart_collections=ShopifyAPI::SmartCollection.find(:all).collect(&:title).join(",")

    @selected_products_count = @funnel_products.count
    @selected_upsell_products_count = @funnel_upsell_products.count
    @selected_downsell_products_count = @funnel_downsell_products.count
  end

  # POST /funnels
  # POST /funnels.json
  def create
    render json: params and return
    @funnel = @shop.funnels.create(funnel_params)
    if @funnel.present?
      funnel_product_ids = FilterShopProduct.where(product_id: params[:funnel][:funnel_product_ids].split(',')).ids
      upsell_product_ids = FilterShopProduct.where(product_id: params[:funnel][:upsell_product_ids].split(',')).ids
      downsell_product_ids = FilterShopProduct.where(product_id: params[:funnel][:downsell_product_ids].split(',')).ids
      @funnel.filter_shop_product_ids = funnel_product_ids if funnel_product_ids.present?
      @funnel.upsell_filter_product_ids = upsell_product_ids if upsell_product_ids.present?
      @funnel.downsell_filter_product_ids = downsell_product_ids if downsell_product_ids.present?
      # Funnel.first.filter_shop_product_ids = [1, 2, 3, 4, 5]
      # params[funnel][funnel_product_ids]
    end
    respond_to do |format|
      if @funnel.save
        format.html { redirect_to root_path, notice: 'Funnel was successfully created.' }
        format.json { render :show, status: :created, location: @funnel }
      else
        format.html { redirect_to new_funnel_path }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    @funnel = Funnel.find(params[:id])
    if @funnel.present?
      funnel_product_ids = FilterShopProduct.where(product_id: params[:funnel][:funnel_product_ids].split(',')).ids
      upsell_product_ids = FilterShopProduct.where(product_id: params[:funnel][:upsell_product_ids].split(',')).ids
      downsell_product_ids = FilterShopProduct.where(product_id: params[:funnel][:downsell_product_ids].split(',')).ids
      @funnel.filter_shop_product_ids = funnel_product_ids if funnel_product_ids.present?
      @funnel.upsell_filter_product_ids = upsell_product_ids if upsell_product_ids.present?
      @funnel.downsell_filter_product_ids = downsell_product_ids if downsell_product_ids.present?
    end
    respond_to do |format|
      if @funnel.update(funnel_params)
        format.html { redirect_to root_path, notice: 'Funnel was successfully updated.' }
        format.json { render :show, status: :created, location: @funnel }
      else
        format.html { redirect_to edit_funnel_path }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @funnel = @shop.funnels.find(params[:id])
    puts "<*****************in destroy and funnel==>#{@funnel.inspect}********>"
    @funnel.destroy if @funnel.present?
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Funnel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    puts "<=======#{@funnel.inspect}=========>"
    @funnel.update(is_active: !@funnel.is_active)
    respond_to :js
  end

  def design_test
    render :layout => false
  end

  def test
    render json: request.url and return
  end

  private
    def set_funnel
      @funnel = Funnel.find(params[:id])
    end

    def set_current_shop
      @current_shop = ShopifyAPI::Shop.current
      @shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
    end

    def funnel_params
      params.require(:funnel).permit(:name, :up_sell_title, :down_sell_title, :down_sell_time_out, :is_advance_colors, :is_active, :shop_id, :is_display_desc, :is_skip_cart)
    end
end
