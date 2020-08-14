module Enumerable
  def my_each
    if self.is_a?(Array)
      self.length.times do |i| yield(self[i]) end
    elsif self.is_a? (Hash)
      self.length.times do |i| yield(self.keys[i], self.values[i]) end
    end

    self
  end

  def my_each_with_index
    self.length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select
    select = []
    select.my_each do |i|
      if yield(i)
        select.push(i)
      end
    end
  end

  def my_all?
    result = true
    if self.is_a?(Array)
      self.my_each do |item| result = false unless yield(item) end
    elsif self.is_a(Hash)
      self.my_each do |k, v| result = false unless yield(k, v) end
    end

    result
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
end
