# frozen_string_literal: true

module Enumerable
  def my_each
    if is_a?(Array)
      length.times { |i| yield(self[i]) }
    elsif is_a? Hash
      length.times { |i| yield(keys[i], values[i]) }
    end

    self
  end

  def my_each_with_index
    length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select
    select = []
    select.my_each do |i|
      select.push(i) if yield(i)
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
      my_each do |i|
        result << (block.nil? ? yield(i) : block.call(i))
      end
    elsif is_a?(Hash)
      my_each do |k, v|
        result << (block.nil? ? yield(k, v) : block.call(k, v))
      end
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
      return t * i
    end
  end
end
