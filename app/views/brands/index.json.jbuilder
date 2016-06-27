json.array!(@brands) do |brand|
  json.extract! brand, :id, :user_id, :color_a, :color_b
  json.url brand_url(brand, format: :json)
end
