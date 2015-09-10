class MediaController < ApplicationController

  def create
    form_type = "#{params[:medium][:media_type].titleize}Form".constantize
    @medium = form_type.new(Medium.new)
    @plan = Plan.find(medium_params[:plan_id])
    merged_params = medium_params
    merged_params[:source_id] = parse_spotify_id(params[:medium]) if params[:medium][:media_type] == 'spotify'
    if @medium.validate(merged_params)
      @medium.save
      redirect_to :back
    else
      render '/plans/show'
    end
  end

  def destroy
    Medium.find(params[:id]).destroy
    redirect_to plan_path(Plan.find params[:plan_id])
  end

  private
 
  def medium_params
    params.require(:medium).permit(:url, :plan_id, :media_type)
  end

  def parse_spotify_id(medium)
    /(?<=track.).+/.match(medium[:url])[0]
  end
end
