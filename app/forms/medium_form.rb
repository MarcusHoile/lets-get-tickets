class MediumForm < ::Reform::Form
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  property :url
  property :event_id

  validates :url, presence: {format: YT_LINK_FORMAT}
end
