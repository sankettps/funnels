module FrontendHelper
	
	def modal_html
		@html = "<div id=\"hfUpsellModal\" class=\"modal fade hf-upsell\" role=\"dialog\">
		  <div class=\"modal-dialog\">
		    <!-- Modal content-->
		    <div class=\"modal-content\">
		      <div class=\"modal-header\">
		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
		          <span aria-hidden=\"true\">&times;</span>
		        </button>
		        <h4 class=\"modal-title text-center\">#{@funnel.name}</h4>
		      </div>
		      <div id=\"hfUpsellBody\">
			      <div class=\"modal-body\">
				      <div class=\"row\">
				      		<div class=\"col-xs-6\">
				      			<img src=\"#{@up_product.image.src}\" class=\"hf-pro-img\">
				      		</div>
				      		<div class=\"col-xs-6\">
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<h4> #{@up_product.title} </h4>
				      				</div>
				      			</div>
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<p class=\"pro-price\">#{@shop.currency_symbol} #{@up_variant.price}</p>
				      					<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
				      					<input type=\"hidden\" name=\"\" id=\"hfUpsellProduct\" value=\"#{@up_product.id}\">
				      					<input type=\"hidden\" name=\"\" id=\"hfProduct\" value=\"#{@filter_product.product_id}\">
				      				</div>
				      			</div>
				      			<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
								<div class=\"product-single__variants\">
									<select name=\"id\" id=\"herofunnelUpProduct\" class=\"product-single__variants\">"
									@up_product.variants.each do |variant|
										@html += "<option data-sku='#{variant.sku}' value='#{variant.id}' data-price='#{variant.price}' data-image='#{@up_product_img_array[variant.id]}'>#{variant.title}</option>"
										end
									@html += "</select>
								</div>
				   			</div>
				      </div>
				      <div class=\"row upSellDes\">
		    				<div class=\"col-xs-12\">
		      				<div class=\"hf-pro-desc\">
		      					#{@up_product.body_html.html_safe}
		      				</div>
		    				</div>
    					</div>
				    </div>
				    <div class=\"modal-footer text-center\">
					    <button type=\"button\" class=\"btn btn-success\" id=\"hfUpsellBuy\">Buy Now</button>
					    <button type=\"button\" class=\"btn btn-default\" id=\"hfUpsellCancel\">No, thanks</button>
						</div>
		      		</div>
		     
		      <div id=\"hfDownsellBody\" style=\"display:none;\">
			      <div class=\"modal-body\">
				      <div class=\"row\">
				      		<div class=\"col-xs-6\">
				      			<img src=\"#{@down_product.image.src}\" class=\"hf-pro-img\">
				      		</div>
				      		<div class=\"col-xs-6\">
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<h4> #{@down_product.title} </h4>
				      				</div>
				      			</div>
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<p class=\"pro-price\">#{@shop.currency_symbol} #{@up_variant.price}</p>
				      					<input type=\"hidden\" name=\"\" id=\"hfDownsellVariant\" value=\"#{@down_variant.id}\">
				      					<input type=\"hidden\" name=\"\" id=\"hfDownsellProduct\" value=\"#{@down_product.id}\">
				      				</div>
				      			</div>
				      			<input type=\"hidden\" name=\"\" id=\"hfDownsellVariant\" value=\"#{@up_variant.id}\">
										<div class=\"product-single__variants\">
											<select name=\"id\" id=\"herofunnelDownProduct\" class=\"product-single__variants\">"
											@down_product.variants.each do |variant|
												@html += "<option data-sku='#{variant.sku}' value='#{variant.id}' data-price='#{variant.price}' data-image='#{@down_product_img_array[variant.id]}'>#{variant.title}</option>"
												end
											@html += "</select>
										</div>
						     </div>
				      </div>
				      <div class=\"row downSellDes\">
		    				<div class=\"col-xs-12\">
		      				<div class=\"hf-pro-desc\">
		      					#{@down_product.body_html.html_safe}
		      				</div>
		    				</div>
		    			</div>
		    			<div class=\"modal-footer text-center\">
				        <button type=\"button\" class=\"btn btn-success\" id=\"hfDownsellBuy\">Buy Now</button>
				        <button type=\"button\" class=\"btn btn-default\" id=\"hfDownsellCancel\">No, thanks</button>
				      </div>
				    </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<script>
			var selectUpsellCallback = function(variant, selector) {
						$('#hfUpsellVariant').val($('#herofunnelUpProduct').val());
		        $('#hfUpsellBody .pro-price').html('#{@shop.currency_symbol}'+$('#herofunnelUpProduct').find(':selected').attr('data-price'));
		        if($('#herofunnelUpProduct').find(':selected').attr('data-image')){
					$('#hfUpsellBody .hf-pro-img').attr('src',$('#herofunnelUpProduct').find(':selected').attr('data-image'));
				}
		     };

			this.optionSelector = new Shopify.OptionSelectors('herofunnelUpProduct', {
		        product: #{@up_product.to_json},
		        onVariantSelected: selectUpsellCallback,
		        enableHistoryState: this.enableHistoryState
		      });

		   var selectDownsellCallback = function(variant, selector) {
		   		$('#hfDownsellVariant').val($('#herofunnelDownProduct').val());
		        $('#hfDownsellBody .pro-price').html('#{@shop.currency_symbol}'+$('#herofunnelDownProduct').find(':selected').attr('data-price'));
		        if($('#herofunnelDownProduct').find(':selected').attr('data-image')){
					$('#hfDownsellBody .hf-pro-img').attr('src',$('#herofunnelDownProduct').find(':selected').attr('data-image'));
				}
		     };

			this.optionSelector = new Shopify.OptionSelectors('herofunnelDownProduct', {
		        product: #{@down_product.to_json},
		        onVariantSelected: selectDownsellCallback,
		        enableHistoryState: this.enableHistoryState
		      });
		</script>
		<style type=\"text/css\">
			.hf-upsell .hf-pro-img{
				width: 100%;
			}
			.hf-pro-desc{
			  /*white-space: nowrap;*/
			  overflow: hidden;
			  text-overflow: ellipsis;
			  max-width: 100%;
			  max-height: 180px;
			}
			.hf-upsell .pro-price{
				float: left;
		    font-size: 30px;
		    color: #4aae4e;
		    margin-right: 15px;
			}
		</style>"
	end

	def downsell_modal_html
		down_body_html
		@html = "<div id=\"hfDownsellModal\" class=\"modal fade hf-downsell\" role=\"dialog\">
		  <div class=\"modal-dialog\">
		    <!-- Modal content-->
		    <div class=\"modal-content\">
		      <div class=\"modal-header\">
		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
		          <span aria-hidden=\"true\">&times;</span>
		        </button>
		        <h4 class=\"modal-title text-center\">#{@funnel.down_sell_title}</h4>
		      </div>
		      
		     #{@downsell_body}
		      
		    </div>
		  </div>
		</div>
		
		<style type=\"text/css\">
			.hf-downsell .modal-title{
				color: #{@funnel.downsell_css["title_text_color"]};
			}
			.hf-downsell .buy-button{
				color: #{@funnel.downsell_css["buy_text_color"]} !important;
				background-color: #{@funnel.downsell_css["buy_bg_color"]} !important;
			}
			.hf-downsell .cancel-button{
				color: #{@funnel.downsell_css["cancel_text_color"]} !important;
				background-color: #{@funnel.downsell_css["cancel_bg_color"]} !important;
			}
		</style>"
	end
	
	def down_body_html
		@downsell_body = ''
		@funnel.downsell_products.each_with_index do |down_product,index|
			down_product.filter_shop_product

			@downsell_body += "<div id=\"downProduct#{index}\" style='display: #{index == 0 ? "block" : "none"};'>
	      <div class=\"modal-body\">
		      <div class=\"row\">
		      		<div class=\"col-xs-6\">
		      			<img src=\"#{down_product.filter_shop_product.image}\" class=\"hf-pro-img\">
		      		</div>
		      		<div class=\"col-xs-6\">
		      			<div class=\"row\">
		      				<div class=\"col-xs-12\">
		      					<h4> #{down_product.filter_shop_product.product_id} </h4>
		      				</div>
		      			</div>
				     </div>
		      </div>
		      <div class=\"row downSellDes\">
    				<div class=\"col-xs-12\">
      				<div class=\"hf-pro-desc\">
      					Lorem Ipsum downnnnnnnnn
      				</div>
    				</div>
					</div>
		    </div>
		    <div class=\"modal-footer text-center\">
			    <button type=\"button\" class=\"btn btn-success buy-button\" id=\"hfUpsellBuy\">Buy Now</button>
			    <button type=\"button\" data-next=\"downProduct#{index+1}\" data-current=\"downProduct#{index}\" class=\"btn btn-default downsell-cancel cancel-button\" id=\"hfUpsellCancel\">No, thanks</button>
				</div>
      </div>"
		end
	end

	def upsell_modal_html
		up_body_html
		@html = "<div id=\"hfUpsellModal\" class=\"modal fade hf-upsell\" role=\"dialog\">
		  <div class=\"modal-dialog\">
		    <!-- Modal content-->
		    <div class=\"modal-content\">
		      <div class=\"modal-header\">
		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
		          <span aria-hidden=\"true\">&times;</span>
		        </button>
		        <h4 class=\"modal-title text-center\">#{@funnel.up_sell_title}</h4>
		      </div>
		      
		     #{@upsell_body}
		      
		    </div>
		  </div>
		</div>
		
		<style type=\"text/css\">
			.hf-upsell .modal-title{
				color: #{@funnel.upsell_css["title_text_color"]};
			}
			.hf-upsell .buy-button{
				color: #{@funnel.upsell_css["buy_text_color"]} !important;
				background-color: #{@funnel.upsell_css["buy_bg_color"]} !important;
			}
			.hf-upsell .cancel-button{
				color: #{@funnel.upsell_css["cancel_text_color"]} !important;
				background-color: #{@funnel.upsell_css["cancel_bg_color"]} !important;
			}
		</style>"
	end
	
	def up_body_html
		@upsell_body = ''
		@funnel.upsell_products.each_with_index do |up_product,index|
			# up_product.filter_shop_product
			@up_product = ShopifyAPI::Product.find(up_product.filter_shop_product.product_id)
			puts "UP PRoduct=====================#{@up_product.inspect}"
			@upsell_body += "<div id=\"upProduct#{index}\" style='display: #{index == 0 ? "block" : "none"};'>
	      <div class=\"modal-body\">
		      <div class=\"row\">
		      		<div class=\"col-xs-6\">
		      			<img src=\"#{up_product.filter_shop_product.image}\" class=\"hf-pro-img\">
		      		</div>
		      		<div class=\"col-xs-6\">
		      			<div class=\"row\">
		      				<div class=\"col-xs-12\">
		      					<h4> #{up_product.filter_shop_product.product_id} </h4>
		      				</div>
		      			</div>
				     </div>
				     <div class=\"col-xs-6\">
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<h4> #{@up_product.title} </h4>
				      				</div>
				      			</div>
				      			<div class=\"row\">
				      				<div class=\"col-xs-12\">
				      					<p class=\"pro-price\">#{@shop.currency_symbol} #{@up_variant.price}</p>
				      					<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
				      					<input type=\"hidden\" name=\"\" id=\"hfUpsellProduct\" value=\"#{@up_product.id}\">
				      					<input type=\"hidden\" name=\"\" id=\"hfProduct\" value=\"#{@filter_product.product_id}\">
				      				</div>
				      			</div>
				      			<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
								<div class=\"product-single__variants\">
									<select name=\"id\" id=\"herofunnelUpProduct\" class=\"product-single__variants\">"
									@up_product.variants.each do |variant|
										@html += "<option data-sku='#{variant.sku}' value='#{variant.id}' data-price='#{variant.price}' data-image='#{@up_product_img_array[variant.id]}'>#{variant.title}</option>"
										end
									@html += "</select>
								</div>
				   			</div>
		      </div>
		      <div class=\"row up-sell-des\">
    				<div class=\"col-xs-12\">
      				<div class=\"hf-pro-desc\">
      					Lorem Ipsum downnnnnnnnn
      				</div>
    				</div>
					</div>
		    </div>
		    <div class=\"modal-footer text-center\">
			    <button type=\"button\" class=\"btn btn-success buy-button\" id=\"hfUpsellBuy\">Buy Now</button>
			    <button type=\"button\" data-next=\"upProduct#{index+1}\" data-current=\"upProduct#{index}\" class=\"btn btn-default upsell-cancel cancel-button\" id=\"hfUpsellCancel\">No, thanks</button>
				</div>
      </div>"
		end
	end
end
