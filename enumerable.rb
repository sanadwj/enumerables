# rubocop:disable Style/For

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
    elsif arg.nil?
      my_each { |i| return false if i.nil? || i == false }
    else
      my_each { |i| return false if i != arg }
    end
    true
  end

  def my_any?(arg = true)
    if block_given?
      my_each { |x| return false if yield(x) == false }
      return true
    elsif arg.nil?
      my_each { |i| return true if i.nil? || i == false }
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
    else
      my_each { |i| return false if i == true }
    end
    true
  end

  def my_count(count = nil)
    return count if count
    return length unless block_given?

    my_select { |x| yield x }.length
  end

  def my_map(my_proc = nil)
    return to_enum unless block_given?

    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  def my_inject(*args)
    case args.length
      when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
      when 2 then result, sym = args.first, args.last
    end

    # a = a || b
    # a ||= b
    result ||= 0
    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  def multiply_els(list)
    list.my_inject(1, :*)
  end
end

# rubocop:enable Style/For
