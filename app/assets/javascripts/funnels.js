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
	  	if ($(".up_product_id").val().trim().length == 0) {
				$("#upSellPanel").removeClass('panel-default').addClass('panel-danger')
				$("#upSellPanel li").text('Please select product').addClass('input-error');
	  		event.preventDefault(); 
	  	}
	  	if ($(".down_product_id").val().trim().length == 0) {
				$("#downSellPanel").removeClass('panel-default').addClass('panel-danger');
				$("#downSellPanel li").text('Please select product').addClass('input-error');
	  		event.preventDefault(); 
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