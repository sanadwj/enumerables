# rubocop:disable Style/For

# rubocop: disable Metrics/CyclomaticComplexity

# rubocop:disable Metrics/PerceivedComplexity

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
      my_each { |x| return false if x.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return true if i.nil? || i == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return true if x.match(x) }
    else
      my_each { |i| return true if i == true }
    end
    false
  end

  def my_none?(arg = false)
    if block_given?
      my_each { |x| return false if yield(x) == true }
      return true
    elsif arg.nil?
      my_each { |i| return true if i.nil? || i == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return false if x.match(arg) }
      return true
    else
      my_each { |i| return false if i == true }
    end
    true
  end

  def my_count(count = nil)
    return count if count
    return size unless block_given?

    my_each { |x| yield x }.size 
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

    case args.length
    when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
    when 2 then result = args.first
                sym = args.last
    end

    result ||= 0
    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  def multiply_els(array)
    array.my_inject(1, :*)
  end
end

# rubocop:enable Style/For

# rubocop: enable Metrics/CyclomaticComplexity

# rubocop:enable Metrics/PerceivedComplexity

