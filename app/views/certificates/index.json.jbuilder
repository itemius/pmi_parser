json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :last_name, :first_name, :city, :credential, :earned, :status
  json.url certificate_url(certificate, format: :json)
end
