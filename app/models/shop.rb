class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :filter_shop_attributes, dependent: :destroy # shops tags/vendors/types
  has_many :filter_shop_products, dependent: :destroy # products of shop from shopify 
  has_many :funnels, dependent: :destroy # funnels of shops 
  has_many :funnel_reports, dependent: :destroy # funnels of shops 
  after_create :set_configuration
  after_update :set_configuration, if: ->(obj){ obj.shopify_token_changed? }
  
  def set_configuration
    @shop_url ="https://#{ShopifyApp.configuration.api_key}:#{self.shopify_token}@#{self.shopify_domain}/admin/"
    ShopifyAPI::Base.site = @shop_url
    @theme = ShopifyAPI::Theme.find(:all).where(role: 'main').first
    @asset = ShopifyAPI::Asset.find('layout/theme.liquid', :params => { :theme_id => @theme.id})
    @asset_value = @asset.value
    @asset.update_attributes(value: @asset_value.gsub('</body>',"<div id='hfUpsell'></div>{{ 'hf_common.js' | asset_url | script_tag }}</body>")) unless @asset_value.include?("<div id='hfUpsell'>")
    
    @asset = ShopifyAPI::Asset.create(:key => 'assets/hf_common.js', value: '
	    $.getScript("//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js", function(){
	    	$.ajax({
		      url: \''+ENV["hf_domain"]+'/frontend/get_upsell_detail\',
		      data: {shop_id: "{{shop.permanent_domain}}",product_id: "{{product.id}}"},
		    })
		    .done(function(data) {
		      console.log("success funnel");
		      jQuery("head").append(\'<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" id="bt-removable-css">\');
		      $("#hfUpsell").html(data.data);
		    })
		    .fail(function() {
		      console.log("error");
		    })
		    $.getScript( "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js", function( ) {
			    jQuery(\'form[action="/cart/add"]\').submit(function(e) {
				    e.preventDefault();
				    $("#hfDownsellBody").hide();
						$("#hfUpsellBody").show();
				    $("#hfUpsellModal").modal();
				  });
				});
		    $.getScript("https://cdnjs.cloudflare.com/ajax/libs/shopify-cartjs/0.4.1/cart.min.js", function( ) {
		    	$.getScript("https://cdnjs.cloudflare.com/ajax/libs/shopify-cartjs/0.4.1/rivets-cart.min.js", function( ) {
						jQuery(function() {
				      CartJS.init({{ cart | json }});
				    });
				  }); 
			  });      
    	});
    	$(document).on(\'click\', \'#hfUpsellBuy\', function(event) {
				event.preventDefault();
				CartJS.addItem($("#hfUpsellVariant").val());
				$("#hfUpsellModal").modal(\'hide\');
			});
			
			$(document).on(\'click\', \'#hfUpsellCancel\', function(event) {
				$("#hfDownsellBody").show();
				$("#hfUpsellBody").hide();
			});

			$(document).on(\'click\', \'#hfDownsellBuy\', function(event) {
				event.preventDefault();
				CartJS.addItem($("#hfDownsellVariant").val());
				$("#hfUpsellModal").modal(\'hide\');
			});

			$(document).on(\'click\', \'#hfDownsellCancel\', function(event) {
				$("#hfUpsellModal").modal(\'hide\');
			});

			$.ajax({
	      url: \''+ENV["hf_domain"]+'/frontend/get_downsell_detail\',
		    data: {shop_id: window.herofunnels.store_id,product_id: window.herofunnels.product_id},
		  })
		  .done(function(data) {
		    console.log("success funnel down",data);
		    if(localStorage.getItem("hfDownTrack")){
		  	}
		    else
		    {
					localStorage.setItem("hfDownTrack",\'0\');
		    } 
		    	if (localStorage.getItem("hfDownTrack") == data.track_id){

		    	}
		    	else{
		    		$(".hfDownsellModal1").html(data.data);
		    		console.log(hf_device)
		    		if(hf_device == \'mobile\'){
		    			setTimeout(function(){
								localStorage.setItem("hfDownTrack",data.track_id);
								$("#hfDownsellModal").modal(\'show\');
		    			},data.hf_time_out)
		    		}
		    		else{
		    			$(document.documentElement).on(\'mouseleave\',function(e){
		            if(e.clientY < 20){
		            console.log(e.clientY)
		            if (localStorage.getItem("hfDownTrack") == data.track_id){

		    				}
		    				else{
									localStorage.setItem("hfDownTrack",data.track_id);
									$("#hfDownsellModal").modal(\'show\');
		    				}
		            }
		          });
		    		}
		    	}
		    
		  })
		  .fail(function() {
		    console.log("error");
		  })
    ', :theme_id => @theme.id)

  end
end
