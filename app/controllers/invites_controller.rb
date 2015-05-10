class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  def index
    @invites = Invite.all
  end

  # GET /invites/new
  def new
  end

  def create
  end

  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite.event }
        if invite_params.include?("rsvp")
          format.js
        end
        if invite_params.include?("payment_method")
          format.js { render partial: "update_payment"}
        end
      end
    end
  end

  def destroy
    # you can not destroy invites
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invite_params
    params.require(:invite).permit(:rsvp, :event_id, :payment, :reason, :payment_method)
  end
end
