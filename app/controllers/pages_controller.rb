class PagesController < ApplicationController
	skip_before_action :authenticate_user! 

	# all the static pages are here
  def aboutus
  end

  def contactus
  end

  # landing page has its own layout to support bg image
  def landing
  	render layout: "landing_layout"
  end

end
