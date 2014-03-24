class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User", foreign_key: "user_id"
	has_many :invites
  has_many :users, through: :invites
  has_many :tickets
end
