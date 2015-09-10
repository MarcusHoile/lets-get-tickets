class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://example.com/login"
  	mail(to: @user.email, subject: "Welcome to my site")
  end

  def invite_email(host, guest, plan)
  	@host = host
  	
  	@guest = guest
  	@plan = plan
    @url = event_url(@plan)
    # add invite object id as identifier
  	mail(to: @guest.email, subject: "Let's get tickets for #{plan.what}")
  end

end
