class ImageForm < ::Reform::Form

  model :medium

  property :url
  property :event_id
  property :media_type

end
