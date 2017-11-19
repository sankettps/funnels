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
    @asset.update_attributes(value: @asset_value.gsub('</body>',"<div id='hfUpsell'></div><div id='hfDownsell'></div>{{ 'hf_common.js' | asset_url | script_tag }}</body>")) unless @asset_value.include?("<div id='hfUpsell'>")
    
    @asset = ShopifyAPI::Asset.create(:key => 'assets/hf_common.js', value: '
	    $.getScript("//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js", function(){
	    	$.ajax({
		      url: \''+ENV["hf_domain"]+'/frontend/get_upsell_detail\',
		      data: {shop_id: window.herofunnels.store_id,product_id: window.herofunnels.product_id},
		    })
		    .done(function(data) {
		      console.log("success funnel");
		      if(hfStorageRead("hfUpTrack")){}
			    else
			    {
						hfStorageSave("hfUpTrack",{hfUp: \'0\'},1);
			    } 
			  	if(hfStorageRead("hfUpTrack").hfUp == data.track_id){
			  		console.log("no html")
			  	}
			  	else{
		      	jQuery("head").append(\'<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" id="bt-removable-css">\');
			  		$("#hfUpsell").html(data.data);
			  	}
		    })
		    .fail(function() {
		      console.log("error");
		    })
		    $.getScript( "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js", function( ) {
			    jQuery(\'form[action="/cart/add"]\').submit(function(e) {
				    e.preventDefault();
				    $("#hfUpsellModal").modal();
						hfStorageSave("hfUpTrack",{hfUp: data.track_id},1);
				  });
				});
		    $.getScript("https://cdnjs.cloudflare.com/ajax/libs/shopify-cartjs/0.4.1/cart.min.js", function( ) {
		    	$.getScript("https://cdnjs.cloudflare.com/ajax/libs/shopify-cartjs/0.4.1/rivets-cart.min.js", function( ) {
						jQuery(function() {
				      // CartJS.init({{ cart | json }});
				    });
				  }); 
			  });      
    	});
    	$(document).on(\'click\', \'#hfUpsellBuy\', function(event) {
				event.preventDefault();
				CartJS.addItem($("#hfUpsellVariant").val());
				$("#hfUpsellModal").modal(\'hide\');
			});
			
			$(document).on(\'click\', \'.upsell-cancel\', function(event) {
				console.log($(this).data(\'next\'))
				if($(\'#\'+$(this).data(\'next\')).length){
					console.log("yesssssssss up")
					$(\'#\'+$(this).data(\'current\')).hide();
					$(\'#\'+$(this).data(\'next\')).show();
				}
				else{
					$("#hfUpsellModal").modal(\'hide\');
				}
				// $("#hfUpsellBody").hide();
			});

			$(document).on(\'click\', \'#hfDownsellBuy\', function(event) {
				event.preventDefault();
				CartJS.addItem($("#hfDownsellVariant").val());
				$("#hfUpsellModal").modal(\'hide\');
			});

			$(document).on(\'click\', \'#hfDownsellCancel\', function(event) {
				$("#hfUpsellModal").modal(\'hide\');
			});

			
		  var hfIsMobile = window.matchMedia("only screen and (max-width: 760px)");
		  var hf_device = \desktop\;
		  var hfDownTrack;
		  function hfStorageSave(key, jsonData, expirationMin){
				var expirationMS = expirationMin * 60 * 1000;
				var record = {value: JSON.stringify(jsonData), timestamp: new Date().getTime() + expirationMS}
				localStorage.setItem(key, JSON.stringify(record));
				return jsonData;
			}
			function hfStorageRead(key){
				var record = JSON.parse(localStorage.getItem(key));
				if (!record){return false;}
				return (new Date().getTime() < record.timestamp && JSON.parse(record.value));
			}
		  if (hfIsMobile.matches) {
		    hf_device = \'mobile\';
		  }
			$.ajax({
		    url: \''+ENV["hf_domain"]+'/frontend/get_downsell_detail\',
		    data: {shop_id: window.herofunnels.store_id,product_id: window.herofunnels.product_id},
		  })
		  .done(function(data) {
		    console.log("success funnel",data);
		    // jQuery("head").append(\'<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" id="bt-removable-css">\');
		    if(hfStorageRead("hfDownTrack")){
		    	
		  	}
		    else
		    {
					// localStorage.setItem("hfDownTrack",JSON.stringify(\'hfDown\': \'0\',\'timestamp\': (new Date().getTime() + 86400000));
					hfStorageSave("hfDownTrack",{hfDown: \'0\'},1);
		    } 
		    	if (hfStorageRead("hfDownTrack").hfDown == data.track_id){
		    		console.log("no html")
		    	}
		    	else{
		    		$("#hfDownsell").html(data.data);
		    		console.log(hf_device)
		    		if(hf_device == \'mobile\'){
		    			setTimeout(function(){
								// localStorage.setItem("hfDownTrack",data.track_id);
								hfStorageSave("hfDownTrack",{hfDown: data.track_id},1);
								$("#hfDownsellModal").modal(\'show\');
		    			},data.hf_time_out)
		    		}
		    		else{
		    			$(document.documentElement).on(\'mouseleave\',function(e){
		            if(e.clientY < 20){
		            console.log(e.clientY)
		            if (hfStorageRead("hfDownTrack").hfDown == data.track_id){

		    				}
		    				else{
									hfStorageSave("hfDownTrack",{hfDown: data.track_id},1);
									// localStorage.setItem("hfDownTrack",data.track_id);
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
	    $(document).on(\'click\', \'#test\', function(event) {
				$("#hfDownsellModal").modal(\'show\');
				// $("#hfUpsellBody").hide();
				});
	    $(document).on(\'click\', \'.downsell-cancel\', function(event) {
				console.log($(this).data(\'next\'))
				if($(\'#\'+$(this).data(\'next\')).length){
					console.log("yesssssssss")
					$(\'#\'+$(this).data(\'current\')).hide();
					$(\'#\'+$(this).data(\'next\')).show();
				}
				else{
					$("#hfDownsellModal").modal(\'hide\');
				}
				// $("#hfUpsellBody").hide();
			});
    ', :theme_id => @theme.id)

  end
end
