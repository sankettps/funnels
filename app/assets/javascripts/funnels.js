$(document).ready(function(){
	// $(".funnel-form").submit(function( event ) {
	// 	var fDetailError = false
	// 	if ($("#funnelName").val().trim().length == 0) {
 //    	// do something
 //    	fDetailError = true;
 //    	$("#funnelName").addClass('input-error').focus();
	// 	}
	//   event.preventDefault();
	// });
	$(".funnel-form").validate({
		errorClass: "input-error",
	  rules: {
	    "funnel[name]": {required: true},
	    "funnel[title]": {required: true},
	  },
	  submitHandler: function(form, event) { 
	  	var hFlag = true;
	  	if ($(".up_product_id").val().trim().length == 0) {
				$("#upSellPanel").removeClass('panel-default').addClass('panel-danger')
				$("#upSellPanel li").text('Please select product').addClass('input-error');
	  		hFlag = false;
	  		event.preventDefault(); 
	  	}else{
				$("#upSellPanel").removeClass('panel-danger').addClass('panel-default');
	  	}
	  	if ($(".down_product_id").val().trim().length == 0) {
				$("#downSellPanel").removeClass('panel-default').addClass('panel-danger');
				$("#downSellPanel li").text('Please select product').addClass('input-error');
	  		hFlag = false;
	  		event.preventDefault(); 
	  	}else{
				$("#downSellPanel").removeClass('panel-danger').addClass('panel-default');
	  	}
	  	if ($(".trigger-products").val().trim().length == 0) {
				$("#funnelProducts").removeClass('panel-default').addClass('panel-danger');
				$(".no_products td").text('Please select product').addClass('input-error');
	  		hFlag = false;
	  		event.preventDefault(); 
	  	}else{
				$("#funnelProducts").removeClass('panel-danger').addClass('panel-default');
	  	}
	  	if (hFlag) {
	  		form.submit();
	  	}
	  }
	});
});
// $("#myform").validate({
	// errorClass: "invalid",
//   success: function(label) {
//     label.addClass("valid").text("Ok!")
//   },
//   submitHandler: function(form, event) { event.preventDefault(); }
// });