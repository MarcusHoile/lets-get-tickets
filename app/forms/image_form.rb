class ImageForm < ::Reform::Form

  model :medium

  property :url
  property :plan_id
  property :media_type

end
