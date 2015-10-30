class InviteForm < ::Reform::Form
  property :rsvp
  property :user_id
  property :plan_id
  property :payment
  property :reason
  property :payment_method

  validates :rsvp, presence: true
  validates :user_id, presence: true
  validates :plan_id, presence: true

end
