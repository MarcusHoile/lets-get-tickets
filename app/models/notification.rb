class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :message
end
