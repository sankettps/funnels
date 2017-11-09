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

    # @upsell_product_name = FilterShopProduct.find(@funnel.up_product_id).title
    # @downsell_product_name = FilterShopProduct.find(@funnel.down_product_id).title

  end

  # POST /funnels
  # POST /funnels.json
  def create
    @funnel = Funnel.new(funnel_params)
    params[:funnel][:up_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:up_product_id]).try(:id)
    params[:funnel][:down_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:down_product_id]).try(:id)
    @funnel = @shop.funnels.create(funnel_params)
    if @funnel.present?
      funnel_product_ids = FilterShopProduct.where(product_id: params[:funnel][:funnel_product_ids].split(',')).ids
      @funnel.filter_shop_product_ids = funnel_product_ids if funnel_product_ids.present?
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

  # PATCH/PUT /funnels/1
  # PATCH/PUT /funnels/1.json
  def update
    params[:funnel][:up_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:up_product_id]).try(:id)
    params[:funnel][:down_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:down_product_id]).try(:id)
    if @funnel.present?
      # FunnelProduct.where(funnel_id: params[:id]).destroy_all if FunnelProduct.where(funnel_id: params[:id]).present?
      funnel_product_ids = FilterShopProduct.where(product_id: params[:funnel][:funnel_product_ids].split(',')).ids
      @funnel.filter_shop_product_ids = funnel_product_ids if funnel_product_ids.present?
      # Funnel.first.filter_shop_product_ids = [1, 2, 3, 4, 5]
      # params[funnel][funnel_product_ids]
    end
    # render json: funnel_params and return
    respond_to do |format|
      puts "INNNNNNNN==============#{funnel_params}"
      if @funnel.update(funnel_params)
        format.html { redirect_to root_path, notice: 'Funnel was successfully updated.' }
        format.json { render :show, status: :ok, location: @funnel }
      else
        puts "<===============#{@funnel.errors.inspect}=================>"
        format.html { render :edit }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funnels/1
  # DELETE /funnels/1.json
  def destroy
    @funnel.destroy
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funnel
      @funnel = Funnel.find(params[:id])
    end

    def set_current_shop
      @current_shop = ShopifyAPI::Shop.current
      @shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
      # @current_shop = Shop.first
      # @shop = Shop.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funnel_params
      params.require(:funnel).permit(:name, :title, :up_product_id, :down_product_id, :is_active, :shop_id, :is_display_desc, :redirect_page)
    end
end
