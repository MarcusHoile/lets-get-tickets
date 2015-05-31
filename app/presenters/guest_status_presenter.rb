class GuestStatusPresenter

  def initialize(event)
    @event = event
  end
  
  def guests
    ::Query::Event::Guests.all(event)
  end

  def status
    { places_left: places_left, confirmed: confirmed, undecided: undecided, not_going: not_going }.compact!
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

  attr_reader :event
end
