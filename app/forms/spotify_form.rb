class SpotifyForm < ::Reform::Form

  model :medium

  property :url
  property :source_id
  property :plan_id
  property :media_type

end