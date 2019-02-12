a = [4, 8, 15, 16, 23, 42]
enum = a.to_enum

# Example of external iterator
puts enum.peek
puts enum.next
puts enum.next
puts enum.next
enum.rewind
puts enum.next
puts enum.next
puts enum.next
puts enum.next

puts
enum.rewind
begin
  while true
    puts enum.next
  end
rescue StopIteration
  # Do nothing
end

puts

# Example of internal iterator
enum.each do |x|
  puts x
end

#enum = 42.to_enum
#puts enum.next

class MyClass

  def whatever
    yield 5
    yield 10
    yield 20
  end

  def each
    n = 1
    while n < 2000
      yield n
      n *= 2
    end
  end

end

my = MyClass.new
enum = my.to_enum(:whatever)
puts enum.next
puts enum.next
puts enum.next
enum.rewind
puts enum.next
enum = my.to_enum
p enum.to_a

