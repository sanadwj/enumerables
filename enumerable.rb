# rubocop:disable Style/For

# rubocop:disable Style/BlockComments

# Enumerable module
module Enumerable
  def my_each
    return to_enum unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each { |x| array << x if yield x }

    array
  end

  def my_all?
    return unless block_given?

    result = my_select { |x| yield x }
    length == result.length
  end

  def my_any?
    return unless block_given?

    result = my_select { |x| yield x }
    result.length.positive?
  end

  def my_none?
    return unless block_given?

    result = my_select { |x| yield x }
    !result.length.positive?
  end

  def my_count(count = nil)
    return count if count
    return length unless block_given?

    my_select { |x| yield x }.length
  end

  def my_map(my_proc = nil)
    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  def my_inject(*args)
    case args.length
    when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
    when 2 then result = args.first
                sym = args.last
    end

    result ||= 0
    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  def multiply_els
    my_inject(1, :*)
  end
end

# rubocop:enable Style/For
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

# rubocop:enable Style/BlockComments
