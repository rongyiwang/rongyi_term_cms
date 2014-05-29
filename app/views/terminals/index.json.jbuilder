json.array!(@terminals) do |terminal|
  json.extract! terminal, :id
  json.url terminal_url(terminal, format: :json)
end
