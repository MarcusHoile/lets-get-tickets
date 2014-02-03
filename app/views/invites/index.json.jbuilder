json.array!(@invites) do |invite|
  json.extract! invite, :id, :attending, :user_id, :event_id
  json.url invite_url(invite, format: :json)
end
