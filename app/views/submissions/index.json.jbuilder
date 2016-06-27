json.array!(@submissions) do |submission|
  json.extract! submission, :id, :matrix_id, :user_id
  json.url submission_url(submission, format: :json)
end
