class FrontendController < ApplicationController
	def get_upsell_detail
	 	@shop = Shop.find_by_shopify_domain(params[:shop_id])
	 	if @shop.present?
	 		@funnel = @shop.funnels.find_by(is_active: true)
	 		# @funnel
	 	else
	 		@response = {status: 200, message: 'success' data: ''}
	 	end
	 	render json: @response
		# $.getScript( "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js", function( ) {
  #     $("#test").click(function() {
		# 		console.log(typeof $().modal == 'function')
  #       $('#myModal').modal('show');
		# 	});
  # 	})
	end
end
