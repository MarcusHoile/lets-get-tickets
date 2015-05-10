class PagesController < ApplicationController
  # skip_before_filter :authenticate_user 
	# all the static pages are here
  def aboutus
  end

  def terms
  end
  def privacy
  end
  def support
  end


  # landing page has its own layout to support bg image
  def landing
  	render layout: "landing_layout"
  end
  def campaign
    render layout: "landing_layout"
  end

  def login
    if current_user
      current_user
    end
  end

end
