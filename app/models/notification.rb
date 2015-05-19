class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def message
    ::CONFIG[:notifications][name.to_sym]
  end
end
