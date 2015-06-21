class EventPresenter

  def initialize(event, user)
    @event, @user = event, user
  end
  
  def guests
    ::Query::Event::Guests.all(event)
  end

  def invite
    @invite ||= Invite.find_or_create_by(user_id: user.id, event_id: event.id)
  end

  def active_btns
    invite.rsvp == 'undecided' ? '.going .not-going .maybe' : invite.rsvp
  end

  def guest_rsvpd
    invite.rsvp != 'undecided'
  end

  def invites
    @invites ||= Query::Event::Invites.sorted(event)
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
    @notifications ||= ::Query::Event::Notifications.all(event).for(user)
  end

  def media
    event.media
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
    youtube_video.embed_html.html_safe
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
    event.limited
  end

  def places_left
    confirmed - tickets_available if event.limited
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

  attr_reader :event, :user
end
