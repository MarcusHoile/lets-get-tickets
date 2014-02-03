json.array!(@events) do |event|
  json.extract! event, :id, :when, :what, :description, :where, :user_id
  json.url event_url(event, format: :json)
end
