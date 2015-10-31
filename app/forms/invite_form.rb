class InviteForm < ::Reform::Form
  property :rsvp
  property :guest
  property :plan
  property :payment
  property :reason
  property :payment_method

  validates :rsvp, presence: true
  validates :guest, presence: true
  validates :plan, presence: true

end
