class Message < ActiveRecord::Base
  has_many :notifications
end
