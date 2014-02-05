json.array!(@challenges) do |challenge|
  json.extract! challenge, :user_id, :title, :description, :views, :tag, :image
  json.url challenge_url(challenge, format: :json)
end