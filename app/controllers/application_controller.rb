class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_filter :authenticate_user
  before_filter :current_user
  before_filter :current_path
  helper_method :current_user, :guest_user, :authenticated_user, :current_path
  # TODO do i need these?
  require "erb"
  include ERB::Util
  
  def current_path
    @current_path = url_encode(request.env['PATH_INFO'])
  end

  def current_user
    if authenticated_user
      if session[:guest_user_id]
        migrate_guest_user_data
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      authenticated_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user
  end
  
  private
  
  def authenticated_user
  	@authenticated_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def authenticate_user
    redirect_to :login unless authenticated_user
  end
  
  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to authenticated_user.
  def migrate_guest_user_data
    guest_user.invites.update_all(user_id: authenticated_user.id)
    guest_user.events.update_all(user_id: authenticated_user.id)
  end

  def create_guest_user
    name = "guest_#{Time.now.to_i}#{rand(100)}"
    u = User.create(name: name, email: "#{name}@example.com", guest_user: true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
