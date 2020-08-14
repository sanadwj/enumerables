# frozen_string_literal: true
# def my_each
#   if is_a?(Array)
#     length.times { |i| yield(self[i]) }
#   elsif is_a? Hash
#     length.times { |i| yield(keys[i], values[i]) }
#   end
# end
#
# def my_map(&block)
#   result = []
#   if is_a?(Array)
#     my_each do |item|
#       result << (block.nil? ? yield(item) : block.call(item))
#     end
#   elsif is_a?(Hash)
#     my_each do |k, v|
#       result << (block.nil? ? yield(k, v) : block.call(k, v))
#     end
#   end
#   result
# end
