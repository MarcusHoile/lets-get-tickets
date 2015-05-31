class MediaController < ApplicationController

  def create
    @medium = MediumForm.new(Medium.new)
    @event = Event.find(medium_params[:event_id])
    if @medium.validate(medium_params)
      binding.pry
      video = Yt::Video.new url: @medium.link
      @medium.uid = video.id
      @medium.save
      redirect_to event_path(@event)
    else
      render '/events/show'
    end
  end

  private
 
  def medium_params
    params.require(:medium).permit(:link, :event_id)
  end
end
