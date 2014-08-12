class PagesController < ApplicationController
  skip_before_filter :authenticate_user
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
    if current_user
      user = @current_user
      @event = user.hosted_events.new
    end
    @what = "Sydney Swans vs Port Adelaide"
    @when = "7:30pm Saturday"
    @where = "Adelaide Oval"
    render layout: "campaign"
  end

  def login
    if current_user
      current_user
    end
  end

end
