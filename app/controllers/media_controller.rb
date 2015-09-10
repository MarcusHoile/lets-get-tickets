class MediaController < ApplicationController

  def create
    form_type = "#{params[:medium][:media_type].titleize}Form".constantize
    @medium = form_type.new(Medium.new)
    @plan = Plan.find(medium_params[:event_id])
    merged_params = medium_params
    merged_params[:source_id] = parse_spotify_id(params[:medium]) if params[:medium][:media_type] == 'spotify'
    if @medium.validate(merged_params)
      @medium.save
      redirect_to :back
    else
      render '/events/show'
    end
  end

  def destroy
    Medium.find(params[:id]).destroy
    redirect_to event_path(Plan.find params[:event_id])
  end

  private
 
  def medium_params
    params.require(:medium).permit(:url, :event_id, :media_type)
  end

  def parse_spotify_id(medium)
    /(?<=track.).+/.match(medium[:url])[0]
  end
end
