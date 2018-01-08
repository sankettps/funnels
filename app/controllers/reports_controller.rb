class ReportsController < ShopifyApp::AuthenticatedController
  before_action :set_current_shop
	def upsell_report
		# @funnel_report_data = @shop.funnel_reports.where("temp_date = ?",1.week.ago)
		# @funnel_report_data = @shop.funnel_reports.where("temp_date >= ? AND temp_date <= ?",1.week.ago,Time.now)
		# @upsell_report_data = @shop.funnel_reports.where("temp_date >= ? AND temp_date <= ?",1.week.ago,Time.now).order("temp_date").group_by(&:temp_date)
		@upsell_compare_data = []
		@downsell_compare_data = []
		toDate = Date.today
		fromDate = Date.today - 7.days
		(fromDate..toDate).each do |date|
			puts "fromdate--->#{date}"
			@upsell_report_data = @shop.funnel_reports.where("temp_date BETWEEN ? AND ? ", date.beginning_of_day,date.end_of_day).where.not(up_product_id: nil)
			@upsell_compare_data << {"date" => date.to_s,"viewed" => @upsell_report_data.where(hf_action:'viewed').count,"added" => @upsell_report_data.where(hf_action:'added').count}
			
			@downsell_report_data = @shop.funnel_reports.where("temp_date BETWEEN ? AND ? ", date.beginning_of_day,date.end_of_day).where.not(down_product_id: nil)
			@downsell_compare_data << {date: date.to_s,viewed: @downsell_report_data.where(hf_action:'viewed').count,added: @downsell_report_data.where(hf_action:'added').count}
		
		end
			puts "upsell--->#{@upsell_compare_data}"
			puts "down sell--->#{@downsell_compare_data}"
	end

	def statistics
		@upsell_reports = @shop.funnel_reports.where(hf_type: "upSell")
		@downsell_reports = @shop.funnel_reports.where(hf_type: "downSell")
	end
	
	def set_current_shop
    @current_shop = ShopifyAPI::Shop.current
    @shop = Shop.find_by_shopify_domain(@current_shop.myshopify_domain)
    puts "-------#{@shop.id}--------"
    # @current_shop = Shop.first
    # @shop = Shop.first
  end
end
