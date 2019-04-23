require 'faraday'
require 'json'

# Remember to change the next two lines
API_END_POINT = 'https://wyayq8wyec.execute-api.us-west-2.amazonaws.com/default/testing_scores'
API_KEY = 'fCKe2MeDcc63FLgPhOSho4MRZ4fhal5e3mE5aIyX'

connection = Faraday.new(url: API_END_POINT)
obj = {'initials': 'TL', 'score': 250}
response = connection.post do |req|
  req.headers['x-api-key'] = API_KEY
  req.body = JSON.dump(obj)
end

p response.status

result = JSON.parse(response.body)
p result
