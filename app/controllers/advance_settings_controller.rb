class AdvanceSettingsController < ShopifyApp::AuthenticatedController
# class AdvanceSettingsController < ApplicationController
  before_action :set_advance_setting, only: [:show, :edit, :update, :destroy]
  before_action :set_current_shop

  # GET /advance_settings
  # GET /advance_settings.json
  def index
    @advance_settings = AdvanceSetting.all
  end

  # GET /advance_settings/1
  # GET /advance_settings/1.json
  def show
  end

  # GET /advance_settings/new
  def new
    # @advance_setting = AdvanceSetting.new
    @advance_setting = @shop.advance_setting || @shop.build_advance_setting 
  end

  # GET /advance_settings/1/edit
  def edit
  end

  # POST /advance_settings
  # POST /advance_settings.json
  def create
    @advance_setting = @shop.build_advance_setting(advance_setting_params)

    respond_to do |format|
      if @advance_setting.save
        format.html { redirect_to @advance_setting, notice: 'Advance setting was successfully created.' }
        format.json { render :show, status: :created, location: @advance_setting }
      else
        format.html { render :new }
        format.json { render json: @advance_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advance_settings/1
  # PATCH/PUT /advance_settings/1.json
  def update
    respond_to do |format|
      if @advance_setting.update(advance_setting_params)
        format.html { redirect_to @advance_setting, notice: 'Advance setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @advance_setting }
      else
        format.html { render :edit }
        format.json { render json: @advance_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advance_settings/1
  # DELETE /advance_settings/1.json
  def destroy
    @advance_setting.destroy
    respond_to do |format|
      format.html { redirect_to advance_settings_url, notice: 'Advance setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_current_shop
      @current_shop = ShopifyAPI::Shop.current
        @shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
        # @current_shop = Shop.first
        # @shop = Shop.first
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_advance_setting
      @advance_setting = AdvanceSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advance_setting_params
      params.require(:advance_setting).permit({downsell_css: {}}, {upsell_css: {}}, :shop_id)
    end
end
