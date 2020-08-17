# frozen_string_literal: true

# rubocop:disable Style/For

# Enumerable module
module Enumerable
  def my_each
    return unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  def my_select
    return unless block_given?

    array = []
    my_each { |x| array << x if yield x }

    array
  end

  def my_all?
    return unless block_given?

    result = my_select { |x| yield x }
    length == result.length
  end

  def my_any?
    return unless block_given?

    result = my_select { |x| yield x }
    result.length.positive?
  end

  def my_none?
    return unless block_given?

    result = my_select { |x| yield x }
    !result.length.positive?
  end

  def my_count(count = nil)
    return count if count
    return length unless block_given?

    my_select { |x| yield x }.length
  end

  def my_map(my_proc = nil)
    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  def my_inject(*args)
    case args.length
    when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
    when 2 then result = args.first
                sym = args.last
    end

    result ||= 0
    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  def multiply_els
    my_inject(1, :*)
  end
end

# rubocop:enable Style/For
