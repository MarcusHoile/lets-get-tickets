# provider          string   
# uid               string   
# name              string   
# email             string   
# oauth_token       string   
# oauth_expires_at  datetime 
# image             string   
# guest_user        boolean  

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :invites, dependent: :destroy
  has_many :hosted_events, class_name: "Event", dependent: :destroy
  has_many :event_invitations, through: :invites, source: :event, dependent: :destroy
  has_many :tickets
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def invite_for(event)
    invites.where(event: event).first
  end

  def paid?(event)
    invite_for(event).payment
  end

  def not_paid?(event)
    !paid?(event) && event.booked
  end

  def confirmed_guest?(event)
    paid?(event) && event.closed?
  end

  def first_name
    name.split(' ').first
  end
end
