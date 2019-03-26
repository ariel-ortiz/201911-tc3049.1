require 'json'

def lambda_handler(event:, context:)
  name = 'World'
  query = event['queryStringParameters']
  if query and query['name']
    name = query['name']
  end
  {
    statusCode: 200,
    body: JSON.pretty_generate({
      status: 'OK',
      message: "Hello, #{ name }!"
      })
  }
end
