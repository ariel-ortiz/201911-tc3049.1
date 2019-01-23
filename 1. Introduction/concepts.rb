# An example that uses:
#  - Abstraction
#  - Encapsulation
#  - Inheritance
#  - Polymorphism

class Player < Object

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    "Hello, I'm #{ @name }. I'm a Player object."
  end

end

p = Player.new('Parzival')
puts p.name
p.name = 'Art3mis'
puts p.name

a = [42, p, [4, 5]]
a.each {|obj| puts obj.to_s }
