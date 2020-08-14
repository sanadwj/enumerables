# frozen_string_literal: true

# Enumerable module
module Enumerable
  def my_each
    if is_a?(Array)
      length.times { |i| yield(self[i]) }
    elsif is_a? Hash
      length.times { |i| yield(keys[i], values[i]) }
    end
  end

  def my_each_with_index
    length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select
    if is_a?(Array)
      results = []
      length.times { |i| results << self[i] if yield(self[i]) }
    elsif is_a?(Hash)
      results = {}
      my_each { |k, v| results[k] = v if yield(k, v) }
    end

    results
  end

  def my_all?
    result = true
    if is_a?(Array)
      my_each { |item| result = false unless yield(item) }
    elsif is_a(Hash)
      my_each { |k, v| result = false unless yield(k, v) }
    end

    result
  end

  def my_any?
    result = false
    if is_a?(Array)
      my_each { |item| result = true if yield(item) }
    elsif is_a?(Hash)
      my_each { |k, v| result = true if yield(k, v) }
    end

    result
  end

  def my_none?
    if is_a?(Array)
      result = !my_any? { |item| yield(item) }
    elsif is_a?(Hash)
      result = !my_any? { |k, v| yield(k, v) }
    end

    result
  end

  def my_count(obj = nil)
    result = 0
    my_each { |item| result += 1 if item == obj || obj.nil? }
    result
  end

  def my_map(&block)
    result = []
    if is_a?(Array)
      my_each { |item| result << (block.nil? ? yield(item) : block.call(item)) }
    elsif is_a?(Hash)
      my_each { |k, v| result << (block.nil? ? yield(k, v) : block.call(k, v)) }
    end
    result
  end

  def my_inject(initial_value = nil)
    initial_value = self[0] if initial_value.nil?
    result = initial_value
    my_each { |item| result = yield(result, item) }
    result
  end

  def multiply_els(num)
    num.my_inject(1) { |t, i| t * i }
  end
end

# list = [5, 4, 3, 2, 1]
#
# list.each { |l| puts "#{l}"}
# puts
#
# list.my_each { |l| puts "#{l}"}
# puts
#
# list.my_each_with_index { |l| puts "#{l}"}
# puts
#
# list.my_select { |l| puts "#{l.even?}"}
# puts
#
# list.my_all? { |l| puts "#{l > 3}" }
# puts
#
# list.my_any? { |l| puts "#{l > 3}" }
# puts
#
# list.my_none? { |l| puts "#{l > 3}" }
# puts
#
# list.my_count { |l| puts "#{l}" }
# puts
#
# list.my_map { |l| puts "#{l*l}" }
# puts
#
# list.my_inject { |l| puts "#{l}" }
# puts
#
