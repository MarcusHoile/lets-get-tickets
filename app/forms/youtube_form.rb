class YoutubeForm < ::Reform::Form
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  model :medium

  property :url
  property :plan_id
  property :media_type

  validates :url, presence: {format: YT_LINK_FORMAT}
end
