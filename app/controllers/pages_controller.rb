class PagesController < ApplicationController
	skip_before_action :authenticate_user! 

  def aboutus
  end

  def contactus
  end

  def landing
  end

end
