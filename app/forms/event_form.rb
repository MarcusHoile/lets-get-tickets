class EventForm < ::Reform::Form

  property :when, validates: {presence: true}
  property :what, validates: {presence: true}
  property :where, validates: {presence: true}
  property :deadline, validates: {presence: true}
  property :price, validates: {presence: true}

end
