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
end
