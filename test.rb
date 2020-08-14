def my_each
  if self.is_a?(Array)
    self.length.times do |i| yield(self[i]) end
  elsif self.is_a? (Hash)
    self.length.times do |i| yield(self.keys[i], self.values[i]) end
  end

  self
end

p my_each