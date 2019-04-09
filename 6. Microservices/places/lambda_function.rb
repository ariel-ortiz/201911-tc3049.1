require 'json'
require 'yaml'

YAML_FILE_NAME = 'pugnacious_orc.yaml'
ADVENTURE = YAML.load_file(YAML_FILE_NAME)

ADVENTURE.keys.each do |key|
  ADVENTURE[key]['place'] = key
end

def make_response(status, body)
  {
    statusCode: status,
    body: JSON.pretty_generate(body)
  }
end

def make_place_response(query_string_params)
  if query_string_params.member?('place')
    place = query_string_params['place']
    if ADVENTURE.member?(place)
      return make_response(200, ADVENTURE[place])
    end
  end
  make_response(404, {message: "Incorrect or missing 'place' parameter."})
end

def make_url(host, path, place)
  "https://#{host}/default#{path}/?place=#{place}"
end

def make_places_list_response(event)
  path = event['path']
  headers = event['headers']
  host = headers['Host']
  result = []
  ADVENTURE.keys.sort.each do |key|
    result << {place: key, url: make_url(host, path, key)}
  end
  make_response(200, result)
end

def handle_get(event)
  query_string_params = event['queryStringParameters']
  if query_string_params
    make_place_response(query_string_params)
  else
    make_places_list_response(event)
  end
end

def handle_bad_method(method)
  make_response(405, {message: "Method not supported: #{ method }"})
end

def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'GET'
    handle_get(event)
  else
    handle_bad_method(method)
  end
end
