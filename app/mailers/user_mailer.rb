class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://example.com/login"
  	mail(to: @user.email, subject: "Welcome to my site")
  end

  def invite_email(user, invitee, event)
  	@user = user
  	@url = "http://example.com/event"
  	@invitee = invitee
  	@event = event
  	mail(to: @invitee.email, subject: "Let's get tickets for #{event.what}")
  end

end
