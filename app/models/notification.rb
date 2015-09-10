class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  def message
    ::CONFIG[:notifications][name.to_sym]
  end
end
