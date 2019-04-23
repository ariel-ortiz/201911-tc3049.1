require 'faraday'
require 'json'
require 'pp'

# Remember to change the next two lines
API_END_POINT = 'https://wyayq8wyec.execute-api.us-west-2.amazonaws.com/default/testing_scores'
API_KEY = 'fCKe2MeDcc63FLgPhOSho4MRZ4fhal5e3mE5aIyX'

connection = Faraday.new(url: API_END_POINT)
response = connection.get do |req|
  req.headers['x-api-key'] = API_KEY
end

p response.status

result = JSON.parse(response.body)
pp result
