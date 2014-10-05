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

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.nickname
  #     user.email = auth.info.email
  #   end
  # end

  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"], without_protection: true) do |user|
  #       user.attributes = params
  #       user.valid?
  #     end
  #   else
  #     super
  #   end
  # end

  # def password_required?
  #   super && provider.blank?
  # end

  # def update_with_password(params, *options)
  #   if encrypted_password.blank?
  #     update_attributes(params, *options)
  #   else
  #     super
  #   end
  # end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
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


  # def User.find_for_facebook_oauth(auth, signed_in_resource = nil)
  #   Rails.logger.info "USER INFO #{auth.info}"
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first

  #   if user
  #     Rails.logger.info "UPDATING #{auth.info.image}"
  #     user.name = auth.extra.raw_info.name
  #     user.email = auth.info.email
  #     user.access_token = auth.credentials.token      
  #     user.save
  #   else
  #     user = User.create!(
  #       provider: auth.provider,
  #       uid: auth.uid,
  #       name: auth.extra.raw_info.name,
  #       email: auth.info.email,
  #       access_token: auth.credentials.token
  #       )
  #     puts "NEW USER #{user}"
  #   end
  #   users
  # end

  # def is_admin?
  #   false
  # end

  # def encrypted_password
  #   # dummy to fake out :database_authenticatable.
  #   # when I remove :database_authenticatable, some necessary routes (/users/sign_out) aren't generated.
  # end

end
