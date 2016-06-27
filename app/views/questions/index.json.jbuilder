json.array!(@questions) do |question|
  json.extract! question, :id, :body, :matrix_id
  json.url question_url(question, format: :json)
end
