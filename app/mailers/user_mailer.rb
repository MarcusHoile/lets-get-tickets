class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://example.com/login"
  	mail(to: @user.email, subject: "Welcome to my site")
  end

  def invite_email(user, guest, event)
  	@user = user
  	
  	@guest = guest
  	@event = event
    @url = "http://ltesgettickets.herokuapp.com/events/#{@event.id}"
    # add invite object id as identifier
  	mail(to: @guest.email, subject: "Let's get tickets for #{event.what}")
  end

end
