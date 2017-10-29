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
	      	<form action=\"/cart/add\" method=\"post\" enctype=\"multipart/form-data\" id=\"addToCartForm-product-template\">
			  <div class=\"product-single__variants\">
			    <select name=\"id\" id=\"herofunnelProduct\" class=\"product-single__variants\">
			          <option selected=\"selected\" data-sku=\"5571428-1\" value=\"40960031180\">Yellow - $13.95 USD</option>
			          <option data-sku=\"5571428-10\" value=\"40960031372\">Blue - $13.95 USD</option>
			          <option data-sku=\"5571428-11\" value=\"40960031564\">Red - $13.95 USD</option>
			          <option data-sku=\"5571428-12\" value=\"40960031820\">Light Blue - $13.95 USD</option>
			          <option data-sku=\"5571428-13\" value=\"40960032012\">Red Blue - $13.95 USD</option>
			          <option data-sku=\"5571428-2\" value=\"40960032140\">Pink - $13.95 USD</option>
			          <option data-sku=\"5571428-3\" value=\"40960032332\">Dark Red - $13.95 USD</option>
			          <option data-sku=\"5571428-4\" value=\"40960032716\">Green - $13.95 USD</option>
			          <option data-sku=\"5571428-5\" value=\"40960032972\">Dark Blue - $13.95 USD</option>
			          <option data-sku=\"5571428-6\" value=\"40960033228\">Light Red - $13.95 USD</option>
			          <option data-sku=\"5571428-7\" value=\"40960033484\">Brown - $13.95 USD</option>
			          <option data-sku=\"5571428-8\" value=\"40960033740\">Dark Pink - $13.95 USD</option>
			          <option data-sku=\"5571428-9\" value=\"40960033932\">Black - $13.95 USD</option>
			    </select>
			  </div>
			  <div class=\"grid--uniform product-single__addtocart\">
			    <button type=\"submit\" name=\"add\" id=\"addToCart-product-template\" class=\"btn btn--large btn--full\">
			      <span class=\"add-to-cart-text\">Add to Cart</span>
			    </button>
			  </div>
			</form>
	       <div>
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
<script>
	this.optionSelector = new Shopify.OptionSelectors('herofunnelProduct', {
        product: #{@up_product},
        onVariantSelected: selectCallback,
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
