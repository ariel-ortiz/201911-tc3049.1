require 'aws-sdk-dynamodb'
require 'pp'

dynamodb = Aws::DynamoDB::Client.new

dynamodb.put_item({
  table_name: 'scores',
  item: {
    'initials' => 'DT',
    'timestamp' => Time.now.to_s,
    'score' => 100
  }
})

puts 'Item has been put'
