module FrontendHelper
	def modal_html1
		@html = "<div id=\"hfUpsellModal\" class=\"modal fade\" role=\"dialog\">
			  <div class=\"modal-dialog\">
			    <!-- Modal content-->
			    <div class=\"modal-content\">
			      <div class=\"modal-header\">
			        <h4 class=\"modal-title\">#{@funnel.name}</h4>
			      </div>
			      <div class=\"modal-body\">
			        <p>#{@funnel.up_product.title}</p>
			      </div>
			      <div class=\"modal-footer\">
			        <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>
			      </div>
			    </div>

			  </div>
			</div>"
	end
	
	def modal_html2
		@html = "<div id=\"hfUpsellModal\" class=\"modal fade hf-upsell\" role=\"dialog\">
		  <div class=\"modal-dialog\">
		    <!-- Modal content-->
		    <div class=\"modal-content\">
		      <div class=\"modal-header\">
		        <h4 class=\"modal-title\">#{@funnel.name}</h4>
		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
		          <span aria-hidden=\"true\">&times;</span>
		        </button>
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
			      				</div>
			      			</div>
			      			<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
							<div class=\"product-single__variants\">
							<select name=\"id\" id=\"herofunnelProduct\" class=\"product-single__variants\">"
							@up_product.variants.each do |variant|
								@html += "<option data-sku='#{variant.sku}' value='#{variant.id}' data-price='#{variant.price}' data-image='#{@up_product_img_array[variant.id]}'>#{variant.title}</option>"
								end
							@html += "</select>
							</div>
					     <div>
			      			
			      		</div>
			      	</div>
			      	
			      
		      </div>
		      <div class=\"row\">
			      				<div class=\"col-xs-12\">
				      				<div class=\"hf-pro-desc\">
				      					#{@up_product.body_html.html_safe}
				      				</div>
			      				</div>
			      			</div>
		      <div id=\"hfDownsellBody\" style=\"display:none;\">
			      <div class=\"modal-body\">
			      	<div class=\"row\">
			      		<div class=\"col-xs-6\">
			      			<img src=\" #{@down_product.image.src}\" class=\"hf-pro-img\">
			      		</div>
			      		<div class=\"col-xs-6\">
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
			      					<h4> #{@down_product.title}</h4>
			      				</div>
			      			</div>
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
			      					<p class=\"pro-price\">$ #{@down_variant.price}</p>
			      					<input type=\"hidden\" name=\"\" id=\"hfDownsellVariant\" value=\"#{@down_variant.id}\">
			      				</div>
			      			</div>
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
				      				<div class=\"hf-pro-desc\">
			      					  #{@down_product.body_html.html_safe}
				      				</div>
			      				</div>
			      			</div>
			      		</div>
			      	</div>
			        <div>
			        	
			        </div>
			      </div>
			      <div class=\"modal-footer\">
			        <button type=\"button\" class=\"btn btn-success\" id=\"hfDownsellBuy\">Buy Now</button>
			        <button type=\"button\" class=\"btn btn-default\" id=\"hfDownsellCancel\">Cancel</button>
			      </div>
		      </div>
		    </div>
		    <div class=\"modal-footer\">
			    <button type=\"button\" class=\"btn btn-success\" id=\"hfUpsellBuy\">Buy Now</button>
			    <button type=\"button\" class=\"btn btn-default\" id=\"hfUpsellCancel\">Cancel</button>
			</div>
		  </div>
		</div>
		<script>
			var selectUpsellCallback = function(variant, selector) {
		        $('.hf-upsell .pro-price').html(#{@shop.currency_symbol} $('#herofunnelProduct').find(':selected').attr('data-price'));
		        if($('#herofunnelProduct').find(':selected').attr('data-image')){
					$('.hf-upsell .hf-pro-img').attr('src',$('#herofunnelProduct').find(':selected').attr('data-image'));
				}
		     };

			this.optionSelector = new Shopify.OptionSelectors('herofunnelProduct', {
		        product: #{@up_product.to_json},
		        onVariantSelected: selectUpsellCallback,
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
	def modal_html
		@html = "<div id=\"hfUpsellModal\" class=\"modal fade hf-upsell\" role=\"dialog\">
		  <div class=\"modal-dialog\">
		    <!-- Modal content-->
		    <div class=\"modal-content\">
		      <div class=\"modal-header\">
		        <h4 class=\"modal-title\">#{@funnel.name}</h4>
		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
		          <span aria-hidden=\"true\">&times;</span>
		        </button>
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
			      					<p class=\"pro-price\">$ #{@up_variant.price}</p>
			      					<input type=\"hidden\" name=\"\" id=\"hfUpsellVariant\" value=\"#{@up_variant.id}\">
			      				</div>
			      			</div>
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
				      				<div class=\"hf-pro-desc\">
				      					#{@up_product.body_html.html_safe}
				      				</div>
			      				</div>
			      			</div>
			      		</div>
			      	</div>
			        <div>
			        	
			        </div>
			      </div>
			      <div class=\"modal-footer\">
			        <button type=\"button\" class=\"btn btn-success\" id=\"hfUpsellBuy\">Buy Now</button>
			        <button type=\"button\" class=\"btn btn-default\" id=\"hfUpsellCancel\">Cancel</button>
			      </div>
		      </div>
		      <div id=\"hfDownsellBody\" style=\"display:none;\">
			      <div class=\"modal-body\">
			      	<div class=\"row\">
			      		<div class=\"col-xs-6\">
			      			<img src=\" #{@down_product.image.src}\" class=\"hf-pro-img\">
			      		</div>
			      		<div class=\"col-xs-6\">
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
			      					<h4> #{@down_product.title}</h4>
			      				</div>
			      			</div>
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
			      					<p class=\"pro-price\">$ #{@down_variant.price}</p>
			      					<input type=\"hidden\" name=\"\" id=\"hfDownsellVariant\" value=\"#{@down_variant.id}\">
			      				</div>
			      			</div>
			      			<div class=\"row\">
			      				<div class=\"col-xs-12\">
				      				<div class=\"hf-pro-desc\">
			      					  #{@down_product.body_html.html_safe}
				      				</div>
			      				</div>
			      			</div>
			      		</div>
			      	</div>
			        <div>
			        	
			        </div>
			      </div>
			      <div class=\"modal-footer\">
			        <button type=\"button\" class=\"btn btn-success\" id=\"hfDownsellBuy\">Buy Now</button>
			        <button type=\"button\" class=\"btn btn-default\" id=\"hfDownsellCancel\">Cancel</button>
			      </div>
		      </div>
		    </div>

		  </div>
		</div>
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
end
