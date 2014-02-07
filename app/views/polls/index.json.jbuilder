json.array!(@polls) do |poll|
  json.extract! poll, :user_id, :title, :description, :views, :tag, :image
  json.url poll_url(poll, format: :json)
end