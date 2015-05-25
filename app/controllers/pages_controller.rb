class PagesController < ApplicationController

  def aboutus
  end

  def terms
  end
  def privacy
  end
  def support
  end

  def home
    render layout: "green"
  end

  def landing
    render layout: "green"
  end
end
