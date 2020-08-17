# rubocop:disable Style/RedundantSelf

# Enumerable module
module Enumerable
  # tip: block_given? is a predicator method which return true if you give the method a block and false if not

  def my_each
    # return if not block_given?
    return unless block_given?

    # loop with iterator i in this method
    for i in self
      yield i
    end
  end 
 
  def my_each_with_index
    # return if not block_given?
    return unless block_given?

    # index starts at 0
    index = 0
    # loop with iterator i in this method
    for i in self
      # return i and index
      yield i, index
      # then in the loop index increases 
      index += 1
    end
  end

  def my_select
    # return if not block_given?
    return unless block_given?

    # empty array
    array = []
    # invoking my_each method with a block that pushes x at the end of the array if x is valid
    my_each { |x| array << x if yield x }

    array
  end

  def my_all?
    # return if not block_given?
    return unless block_given?

    # invoking my_select with a valid block
    result = my_select { |x| yield x }

    # return true or false depending on the length provided
    length == result.length
  end

  def my_any?
    # return if not block_given?
    return unless block_given?

    # invoking my_select with a valid block
    result = my_select { |x| yield x }

    # return true when the length is a positive number otherwise return false
    result.length.positive?
  end

  def my_none?
    # return if not block_given?
    return unless block_given?

    # invoking my_select with a valid block
    result = my_select { |x| yield x }

    # return true when the length is a positive number otherwise return false
    !result.length.positive?
  end

  def my_count(count = nil)
    # return true only if count i different from false itself or nil value
    return count if count
    # return the length if not block_given?
    return length unless block_given?

    # invokes my_select method with a valid block and return the length of it
    my_select { |x| yield x }.length
  end

  # method using proc
  def my_map(my_proc = nil)
    # empty array
    array = []
    # invokes my_each method with a block that pushes the x element into the array using "my_proc.call" (similar to yield) if the proc is true
    my_each { |x| array << my_proc.call(x) } if my_proc
    # invokes my_each method and pushes the x element into the array with yield if block_given?
    my_each { |x| array << yield(x) } if block_given?

    # returns the array
    array
  end

  # it take as many arguments as you give 
  def my_inject(*args)
    case args.length 
      when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
      when 2 then result, sym = args.first, args.last
    end
    
    #  if result is undefined or falsey, then evaluate 0 and set result to 0
    result ||= 0

    # invoke my_each method and do a ternary operator for the result, if block_given? is true we yield result and x and if it's false
    # we send the symbol and the element to the result variable
    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    # we return the result
    result
  end

  def multiply_els
    # we invoke the my_inject method only using the case when first argument is 1 and then we multiply the arguments
    my_inject(1, :*)
  end

end

# rubocop:enable Style/RedundantSelf

=begin
# go to enumerable.rb file
# to log this tests on the console use puts or p

# my_each method test
[1, 2, 3, 4].my_each { |num| p num }
puts 

# my_each_with_index method test
[1, 2, 3, 4].my_each_with_index { |num| p num } 
puts 

# my_select method test
# [1, 2, 3, 4].my_select(&:even?)
# => [2, 4]

# my_all? method test
# [2, 4].my_all?(&:even?)
# => true
# [1, 2, 4].my_all?(&:even?)
# => false

# my_any? method test
# [1, 2, 3].my_any?(&:even?)
# => true
# [1, 3, 5].my_any?(&:even?)
# => false

# my_none? method test
# [1, 2, 3].my_none?(&:even?)
# => false
# [1, 3, 5].my_none?(&:even?)
# => true

# my_count method test
# [1, 2, 3].my_count
# => 3
# [1, 2, 3, 2].my_count(2)
# => 2
# [1, 3, 5].my_count { |x| x > 1 }
# => 2

# my_map method test
# [1, 2, 3, 4, 5].my_map { |x| x * 2 }
# => [2, 4, 6, 8, 10]

# my_inject method test
# (5..10).my_inject(:+)
# (5..10).my_inject { |sum, n| sum + n }
# => 45
# (5..10).my_inject(1, :*)
# (5..10).my_inject(1) { |product, n| product * n }
# => 151200

# multiply_els method test 
# [2,4,5].multiply_els
# => 40
=end



