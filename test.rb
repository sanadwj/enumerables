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
p ["ant", "bear", "cat"].all? { |word| word.length >= 3 }
# => true 
p ["ant", "bear", "cat"].all? { |word| word.length >= 4 }
# => false
p [nil, true, 99].my_all?
# => false
p [].my_all? 
# => true

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





