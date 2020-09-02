# rubocop: disable Lint/ParenthesesAsGroupedExpression

require_relative '../enumerable'

describe Enumerable do
  let (:arr) { [1, 2, 3, 4] }
  let (:ans) { [] }
  let (:bool) { [true, false, nil] }
  let (:str) { %w[book pen table] }

  context 'my_each' do
    it 'It should check through array and block' do
      arr.my_each { |x| ans << x * 2 }
      expect(ans).to eq([2, 4, 6, 8])
    end
  end

  context 'my_each_with_index' do
    it 'It should check through array and return the index' do
      arr.my_each_with_index { |_x, y| ans << y }
      expect(ans).to eq([0, 1, 2, 3])
    end
  end

  context 'my_select' do
    it 'Select the items that met the condition ' do
      expect(arr.my_select(&:even?)).to eq([2, 4])
    end
  end

  context 'my_all?' do
    it 'Check if a block or the argument are not given and if there is a false or nil' do
      expect(bool.my_all?).to eq(false)
    end
    it 'Check if a block is given' do
      expect(arr.my_all? { |x| x.is_a?(Integer) }).to be true
    end
    it 'Check if the regex match' do
      expect(str.my_all?(/oo/)).to eq(false)
    end
  end

  context 'my_any?' do
    it 'Check if a block or the argument are not given and if there is a false or nil' do
      expect(bool.my_any?).to eq(true)
    end
    it 'Check if a block is given' do
      expect(arr.my_any? { |x| x.is_a?(Integer) }).to be true
    end
    it 'Check if the regex match' do
      expect(str.my_any?(/oo/)).to eq(true)
    end
  end

  context 'my_none?' do
    it 'Check if a block or the argument are not given and if there is a false or nil' do
      expect(bool.my_none?).to eq(false)
    end
    it 'Check if a block is given' do
      expect(arr.my_none? { |x| x.is_a?(Integer) }).to be false
    end
    it 'Check if the regex match' do
      expect(str.my_none?(/z/)).to eq(true)
    end
  end

  context 'my_count' do
    it 'return the number of the items in the array equal to argument' do
      expect(arr.my_count { |x| x < 3 }).to eq(2)
    end
    it 'return the number of the items in the array if there is no argument' do
      expect(arr.my_count).to eq(4)
    end
    it 'return the number of the items in the array equal to argument' do
      expect(arr.my_count(4)).to eq(1)
    end
  end

  context 'my_map' do
    it 'if a block given returns the result of the block' do
      expect(arr.my_map { |x| x * 3 }).to eq([3, 6, 9, 12])
    end
    it 'of no block given returns enum' do
      expect(arr.my_map { 'hi' }).to eq(%w[hi hi hi hi])
    end
  end

  context 'my_inject' do
    it 'if block given returns acum' do
      expect(arr.my_inject { |acum, x| acum + x }).to eq(10)
    end
    it 'return the multiplies of the array' do
      expect(arr.my_inject(1) { |acum, x| acum * x }).to eq(24)
    end
    it 'if the arument is a sympol returns acum' do
      expect(arr.my_inject(:*)).to eq(24)
    end
  end
end

# rubocop: enable Lint/ParenthesesAsGroupedExpression
