require "spec_helper"

describe Mashed::Mash do
  let(:mash) { Mashed::Mash.new(a: 1, b: 2, c: 3) }

  describe "#to_hash" do
    it { expect(mash.to_hash).to eq("a" => 1, "b" => 2, "c" => 3) }
  end

  describe "#methods" do
    it { expect(mash.methods).to eq(["a", "b", "c"]) }
  end

  describe "#method_missing" do
    it {
      expect(mash.a).to eq(1)
      expect(mash.b).to eq(2)
      expect(mash.c).to eq(3)
    }
  end
end
