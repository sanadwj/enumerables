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
    select = []
    select.my_each do |i|
      select.push(i + 1) if yield(i)
    end
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
    if yield(i)
      true
    else
      my_each do |_i|
        return false
      end
    end
  end

  def my_count
    count = 0
    if yield(i)
      count
    else
      my_each do |_i|
        return count += 1
      end
    end
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

  def multibly_els(num)
    num.my_inject(1) do |t, i|
      t * i
    end
  end
end

list = [5, 4, 3, 2, 1]

list.each { |l| puts "#{l}"}
list.my_each { |l| puts "#{l}"}
list.my_each_with_index { |l| puts "#{l}"}

