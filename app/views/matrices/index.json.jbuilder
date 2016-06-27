json.array!(@matrices) do |matrix|
  json.extract! matrix, :id, :name
  json.url matrix_url(matrix, format: :json)
end
