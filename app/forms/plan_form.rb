class PlanForm < ::Reform::Form

  property :when
  property :what
  property :where
  property :deadline
  property :price
  property :description
  property :timezone
  property :host

  validates :host, presence: true
  validates :when, presence: true
  validates :what, presence: true
  validates :where, presence: true
  validates :deadline, presence: true
  validates :price, presence: true
  validates :price, numericality: {message: 'Price needs to be a whole number'}

end
