json.array!(@benchmark_applications) do |benchmark_application|
  json.extract! benchmark_application, :id, :user_id, :organisation_name, :organisation_turnover, :organisation_employees, :digital_employees, :opt_in
  json.url benchmark_application_url(benchmark_application, format: :json)
end
