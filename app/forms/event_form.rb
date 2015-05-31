class EventForm < ::Reform::Form

  property :when
  property :what
  property :where
  property :deadline
  property :price
  property :description

  validates :when, presence: true
  validates :what, presence: true
  validates :where, presence: true
  validates :deadline, presence: true
  validates :price, presence: true
  validates :price, numericality: {message: 'Price needs to be a whole number'}

end
