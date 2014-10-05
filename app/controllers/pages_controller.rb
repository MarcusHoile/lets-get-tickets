class PagesController < ApplicationController
  # skip_before_filter :authenticate_user 
	# all the static pages are here
  def aboutus
  end

  def contactus
  end

  # landing page has its own layout to support bg image
  def landing
  	render layout: "campaign"
  end
  def campaign
    @what = "Sydney Swans vs Port Adelaide"
    @when = "7:30pm Saturday"
    @where = "Adelaide Oval"
    if current_user
      user = @current_user
      @event = user.hosted_events.new(what: @what, event_when: @when, where: @where)
    else
      @event = Event.new(what: @what, event_when: @when, where: @where)
    end
    
    render layout: "campaign"
  end

  def login
    if current_user
      current_user
    end
  end

end
