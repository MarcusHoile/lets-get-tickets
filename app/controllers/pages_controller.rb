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
    @demo_event = Event.demo
    render layout: "green"
  end

  def landing
    render layout: "green"
  end
end
