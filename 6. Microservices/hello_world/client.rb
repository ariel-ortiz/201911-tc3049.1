require 'faraday'

API_END_POINT = 'https://ou5m4ycn69.execute-api.us-west-2.amazonaws.com/default/hello_world'

connection = Faraday.new(url: API_END_POINT)
response = connection.get do |req|
  req.headers['My-Header'] = 'Value'
  req.params['whatever'] = 'Thanos'
end

puts response.body
