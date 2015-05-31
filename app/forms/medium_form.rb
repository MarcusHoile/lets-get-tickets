class MediumForm < ::Reform::Form
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  property :link
  property :uid
  property :event_id

  validates :link, presence: {format: YT_LINK_FORMAT}
end
