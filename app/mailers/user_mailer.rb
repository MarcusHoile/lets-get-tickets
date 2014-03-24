class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://example.com/login"
  	mail(to: @user.email, subject: "Welcome to my site")
  end

  def invite_email(owner, guest, event)
  	@owner = owner
  	
  	@guest = guest
  	@event = event
    @url = event_url(@event)
    # add invite object id as identifier
  	mail(to: @guest.email, subject: "Let's get tickets for #{event.what}")
  end

end
