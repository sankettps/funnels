// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery.validate.min
//= require jquery-ui
//= require bootstrap
//= require jquery.minicolors
//= require metisMenu
//= require raphael
//= require morris
//= require sb-admin-2
//= require sweetalert
//= require dataTables/jquery.dataTables  
//= require funnels 

$(document).ready(function(){
	$('.glyphicon.glyphicon-question-sign').closest( "a" ).click(function(ev){
	 ev.preventDefault();
	});
});

