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
  has_many :events, dependent: :destroy
  has_many :notifications, dependent: :destroy

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

  def invite_for(plan)
    invites.where(plan: plan).first
  end

  def paid?(plan)
    invite_for(plan).try(:payment)
  end

  def not_paid?(plan)
    !paid?(plan) && plan.booked
  end

  def confirmed_guest?(plan)
    paid?(plan) && plan.closed?
  end

  def first_name
    name.nil? ? 'Guest User' : name.split(' ').first
  end

  def guest_user?
    guest_user == true
  end
end
