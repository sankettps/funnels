class HeroFunnelMailer < ApplicationMailer
	default from: "sankwork@gmail.com"
	
	def contact_us(email,subject,message)
		@email = email
		@subject = subject
		@message = message
		puts "<=========#{@email}============>"
		mail to: @email, subject: @subject
	end
end
