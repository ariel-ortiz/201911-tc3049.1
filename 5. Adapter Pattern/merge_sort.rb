#--------------------------------------------------------------------
# Adapt a Ruby Enumerator object so that it behaves like the
# provided ArrayIterator by [OLSON].
class EnumeratorAdaptor

  def initialize(enumerator)
    @enumerator = enumerator
  end

  def has_next?
    begin
      @enumerator.peek
      true
    rescue StopIteration
      false
    end
  end

  def item
    @enumerator.peek
  end

  def next_item
    if has_next?
      @enumerator.next
    else
      nil
    end
  end
end

#--------------------------------------------------------------------
# Using external iterators to implement merge sort.
# Taken from [OLSEN] p. 132.
def merge(array1, array2)
  merged = []

  iterator1 = EnumeratorAdaptor.new(array1.to_enum)
  iterator2 = EnumeratorAdaptor.new(array2.to_enum)

  while (iterator1.has_next? and iterator2.has_next?)
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # Pick up the leftovers from array1
  while (iterator1.has_next?)
    merged << iterator1.next_item
  end

  # Pick up the leftovers from array2
  while (iterator2.has_next?)
    merged << iterator2.next_item
  end

  merged
end

a1 = [1, 2, 3, 5, 7]
a2 = [0, 1, 4, 6, 10, 12]
p merge(a1, a2)




