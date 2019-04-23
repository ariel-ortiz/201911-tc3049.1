require 'aws-sdk'

sns = Aws::SNS::Client.new()

sns.publish(
  phone_number: '5255XXXXXXXX', # Replace with a valid mobile phone number
  message: 'Hello, from AWS SNS!')

puts 'Message sent'
