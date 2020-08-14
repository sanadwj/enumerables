# frozen_string_literal: true

def my_select
  select = []
  select.my_each do |i|
    if yield(i)
      select.push(i)
      end
  end
end

def my_any? 
  result = false
  if self.is_a?(Array)
    self.my_each do |item| result = true if yield(item) end
  elsif self.is_a?(Hash)
    self.my_each do |k, v| result = true if yield(k, v) end
  end

  result
end

def my_none?
  if yield(i)
    return true
  else
    self.my_each do |i|
      return false
    end
  end
end

def my_count
  count = 0
  if yield(i)
    return count
  else
    self.my_each do |i|
      return count += 1
    end
  end
end