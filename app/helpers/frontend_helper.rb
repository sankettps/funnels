module FrontendHelper
	def modal_html
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
end
