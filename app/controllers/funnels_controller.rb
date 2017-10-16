class FunnelsController < ShopifyApp::AuthenticatedController
# class FunnelsController < ApplicationController
  before_action :set_current_shop
  before_action :set_funnel, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /funnels/1/edit
  def edit
  end

  # POST /funnels
  # POST /funnels.json
  def create
    # @funnel = Funnel.new(funnel_params)
    params[:funnel][:up_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:up_product_id]).try(:id)
    params[:funnel][:down_product_id] = FilterShopProduct.find_by(product_id: params[:funnel][:down_product_id]).try(:id)
    @funnel = @shop.funnels.create(funnel_params)
    if @funnel.present?
      funnel_product_ids = FilterShopProduct.where(product_id: params[funnel][funnel_product_ids].split(',')).ids
      @funnel.filter_shop_product_ids = funnel_product_ids if funnel_product_ids.present?
      # Funnel.first.filter_shop_product_ids = [1, 2, 3, 4, 5]
      # params[funnel][funnel_product_ids]
    end
    respond_to do |format|
      if @funnel.save
        format.html { redirect_to root_path, notice: 'Funnel was successfully created.' }
        format.json { render :show, status: :created, location: @funnel }
      else
        format.html { render :new }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funnels/1
  # PATCH/PUT /funnels/1.json
  def update
    respond_to do |format|
      if @funnel.update(funnel_params)
        format.html { redirect_to @funnel, notice: 'Funnel was successfully updated.' }
        format.json { render :show, status: :ok, location: @funnel }
      else
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
      format.html { redirect_to funnels_url, notice: 'Funnel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funnel
      @funnel = Funnel.find(params[:id])
    end

    def set_current_shop
      @current_shop = ShopifyAPI::Shop.current
      @shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
    # @shop = Shop.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funnel_params
      params.require(:funnel).permit(:name, :title :up_product_id, :down_product_id, :is_active, :shop_id)
    end
end
