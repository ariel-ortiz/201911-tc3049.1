require 'aws-sdk-dynamodb'

dynamodb = Aws::DynamoDB::Client.new

response = dynamodb.scan(table_name: 'scores')

items = response.items
p items
