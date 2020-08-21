# rubocop:disable Style/For

# rubocop: disable Metrics/CyclomaticComplexity

# rubocop:disable Metrics/PerceivedComplexity

# rubocop: disable Metrics/ModuleLength

# rubocop: disable Style/ConditionalAssignment

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

  def my_all?(arg = nil)
    if block_given?
      my_each { |x| return false if yield(x) == false }
      return true
    elsif arg.is_a?(Class)
      my_each { |x| return false unless x.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return false if i.nil? || i == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return false unless x.match(arg) }
    else
      my_each { |i| return false if i != arg }
    end
    true
  end

  def my_any?(arg = true)
    if block_given?
      my_each { |x| return true if yield(x) == true }
      return false
    elsif arg.is_a?(Class)
      my_each { |x| return true if x.is_a?(arg) }
    elsif arg.nil?
      my_each { |x| return true if x.nil? || x == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return true if x.match(arg) }
    elsif arg.is_a?(String)
      my_each { |x| return true if x == arg }
    else
      my_each { |x| return true if x == true }
    end
    false
  end

  def my_none?(arg = false)
    if block_given?
      my_each { |x| return false if yield(x) == true }
      return true
    elsif arg.is_a?(Class)
      my_each { |x| return false unless x.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return true if i.nil? || i == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return false if x.match(arg) }
      return true
    elsif arg.is_a?(String)
      my_each { |x| return false if x == arg }
    else
      my_each { |i| return false if i == true }
    end
    true
  end

  def my_count(count = nil)
    return size if !block_given? && count.nil?

    counter = 0
    my_each { |i| counter += 1 if (block_given? && yield(i)) || (i == count) }

    counter
  end

  def my_map(my_proc = nil)
    return to_enum unless block_given?

    array = []
    if my_proc
      my_each { |x| array << my_proc.call(x) }
    elsif block_given?
      my_each { |x| array << yield(x) }
    end

    array
  end

  def my_inject(*args)
    return yield false if args.empty? && !block_given?

    if args.length == 1
      args.first.is_a?(Symbol) ? sym = args.first : result = args.first
    elsif args.length == 2
      result = args.first
      sym = args.last
    end

    array = is_a?(Range) ? to_a : self
    result ||= array.shift

    array.my_each do |x|
      if block_given?
        result = yield(result, x)
      else
        result = result.send(sym, x)
      end
    end

    result
  end

  def multiply_els(array)
    array.my_inject(1, :*)
  end
end

# rubocop:enable Style/For

# rubocop: enable Metrics/CyclomaticComplexity

# rubocop:enable Metrics/PerceivedComplexity

# rubocop: enable Metrics/ModuleLength

# rubocop: enable Style/ConditionalAssignment