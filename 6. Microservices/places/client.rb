require 'json'
require 'faraday'

# Remember to change the next two lines
URL_PLACES = 'https://rfjfqj9pl4.execute-api.us-west-2.amazonaws.com/default/newplaces'
API_KEY = 'ONT0ZK2e0s9dnQbbIrpE189oTraJbbfu5JXjVzse'

def request_place(place=nil)
  connection = Faraday.new(url: URL_PLACES)
  response = connection.get do |req|
    req.params['place'] = place if place
    req.headers['x-api-key'] = API_KEY
  end
  return JSON.parse(response.body) if response.success?
  raise "Status code: #{response.status} #{response.body}"
end

def request_starting_place_name
  request_place.each do |place|
    return place['place'] if place['place'].start_with? '__'
  end
  raise "No place name with '__' prefix found."
end

def convert_int_to_letter(i)
  ('A'.ord + i).chr
end

def convert_letter_to_int(c)
  c.ord - 'A'.ord
end

def convert_to_string_if_boolean(x)
  case x
  when TrueClass
    'Yes'
  when FalseClass
    'No'
  else
    x
  end
end

def print_options(options)
  options.each_with_index do |option, index|
    letter = convert_int_to_letter(index)
    text = convert_to_string_if_boolean(option['text'])
    puts "#{letter}. #{text}"
  end
  puts 'Q. Quit program'
end

def create_list_of_options(size)
  (0...size).collect {|e| convert_int_to_letter(e)}
end

def valid_input?(user_input, options)
  (options + ['Q']).include? user_input[0]
end

def read_selection(size)
  puts
  options = create_list_of_options(size)
  loop do
    print '> '
    user_input = gets.chomp.upcase
    if valid_input?(user_input, options)
      user_choice = user_input[0]
      exit if user_choice == 'Q'
      puts
      return convert_letter_to_int(user_choice)
    else
      max_letter = options[-1]
      puts "You must select a letter between A and #{max_letter}."
      puts 'Or Q to quit the program.'
    end
  end
end

def line
  puts '~' * 60
end

def game_over(score)
  line
  puts 'G A M E   O V E R'
  line
  puts "Your score: #{score}"
  line
end

def main
  next_place_name = request_starting_place_name
  score = 0
  loop do
    place = request_place(next_place_name)
    score += place['points'] if place['points']
    statement = place['statement']
    puts statement
    puts
    if place['options']
      options = place['options']
      print_options(options)
      selection = read_selection(options.size)
      next_place_name = options[selection]['target']
      line
    else
      game_over(score)
      break
    end
  end

end

main