json.array!(@targets) do |target|
  json.extract! target, :id, :question_answered, :choice, :question_id, :submission_id
  json.url target_url(target, format: :json)
end
