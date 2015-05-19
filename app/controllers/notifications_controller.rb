class NotificationsController < ApplicationController

  def update
    notification = Notification.find params[:id]
    notification.update(notification_params)
    respond_to do |format|
      format.js { head 200 }
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:active)
  end
end
