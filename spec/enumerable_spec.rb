require_relative '../enumerable'

describe Enumerable do
  let (:arr) {[1, 2, 3, 4]}
  let (:ans) {[]}

  context "my_each" do
    it "It should check through array and block" do
      arr.my_each { |x| ans << x * 2}
      expect(ans).to eq([2, 4, 6, 8])
    end
  end

  context "my_each_with_index" do
    it "It should check through array and return the index" do
      arr.my_each_with_index { |x, y| ans << y}
      expect(ans).to eq([0, 1, 2, 3 ])
    end
  end

  context "my_select" do
    it "Select the items that met the condition " do
      expect(arr.my_select { |x| x % 2 == 0}).to eq([2, 4])
    end
  end

end