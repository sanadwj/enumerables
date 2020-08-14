# frozen_string_literal: true

def my_select
  select = []
  select.my_each do |i|
    if yield(i)
      select.push(i)
      end
  end
end
