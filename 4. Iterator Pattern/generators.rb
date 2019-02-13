def powers_of_two(limit)
  Enumerator.new do |yielder|
    n = 1
    while n <= limit
      yielder << n
      n *= 2
    end
  end
end

enum = powers_of_two(2000)

puts enum.next
puts enum.next

enum.rewind

puts enum.next

enum.each do |x|
  puts x
end

p enum.to_a

class InOrderTraversal

  def initialize(tree)
    @tree = tree
  end

  def traverse
    Enumerator.new do |yielder|
      @yielder = yielder
      inorder(@tree)
    end
  end

  private

  def inorder(root)
    if root
      inorder(root[1])
      @yielder << root[0]
      inorder(root[2])
    end
  end

end

tree = ["A",
        ["B", nil, nil],
        ["C",
         ["D", nil, nil],
         ["E", nil, nil]]]

enum = InOrderTraversal.new(tree).traverse
p enum.to_a
enum.each do |x|
  puts "#{ x }#{ x }"
end

