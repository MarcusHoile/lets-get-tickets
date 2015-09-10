module Presenter
  class Plan < ::Presenter::Base

    presents :plan

    def initialize(object, user, view_context)
      super(object, view_context)
      @user = user
    end

    def host_name
      host?(user) ? "You" : host.try(:first_name) 
    end
    
    def guests
      ::Query::Plan::Guests.all(plan)
    end

    def invite
      @invite ||= Invite.find_or_create_by(user_id: user.id, plan_id: plan.id)
    end

    def active_btns
      invite.rsvp == 'undecided' ? '.going .not-going .maybe' : invite.rsvp
    end

    def guest_rsvpd
      invite.rsvp != 'undecided'
    end

    def invites
      @invites ||= Query::Plan::Invites.sorted(plan)
    end

    def guest_shortlist
      guest_list[0..4]
    end

    def rest_of_guests
      guest_list[5..-1]
    end

    def guest_list
      other_invites = invites.reject { |i| i == invite }
      @guest_list ||= guest_rsvpd ? other_invites.unshift(invite) : other_invites
    end

    def notifications
      @notifications ||= ::Query::Plan::Notifications.all(plan).for(user)
    end

    def video
      media.where(media_type: 'youtube').last
    end

    def image
      media.where(media_type: 'image').last
    end

    def music
      media.where(media_type: 'spotify').last
    end

    def youtube_video
      Yt::Video.new url: video.url
    end

    def video_embed
      # TODO embed html hangs on local
      youtube_video.embed_html.html_safe if Rails.env.production?
    end

    def forms
      { youtube: youtube_form, image: image_form, spotify: spotify_form }
    end

    def youtube_form
      ::YoutubeForm.new(Medium.new)
    end

    def image_form
      ::ImageForm.new(Medium.new)
    end
    
    def spotify_form
      ::SpotifyForm.new(Medium.new)
    end

    def status
      { places_left: places_left, confirmed: confirmed, maybe: maybe, not_going: not_going, undecided: undecided }.compact!
    end

    def columns
      12 / status.count
    end

    def tickets_available
      plan.limited
    end

    def places_left
      confirmed - tickets_available if plan.limited
    end

    def confirmed
      guests.confirmed.count
    end

    def undecided
      guests.undecided.count
    end

    def not_going
      guests.not_going.count
    end

    def maybe
      guests.maybe.count
    end

    def open_btn_class
      open? ? 'active' : 'inactive'
    end

    def closed_btn_class
      open? ? 'inactive' : 'active'
    end

    attr_reader :user
  end
end
