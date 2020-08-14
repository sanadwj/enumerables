# frozen_string_literal: true

def my_select
  select = []
  select.my_each do |i|
    select.push(i) if yield(i)
  end
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

def my_map
  result = []
  if is_a?(Array)
    my_each { |item| result << yield(item) }
  elsif is_a?(Hash)
    my_each { |_item| result << yield(k, v) }
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

def my_map(&block)
  result = []
    if self.is_a?(Array)
      self.my_each do |i|
        block.nil? ? result << yield(i) : result << block.call(i) end
    elsif self.is_a?(Hash)
      self.my_each do |k, v|
        block.nil? ? result << yield(k, v) : result << block.call(k, v) end
    end
  end
  result
end