require "spec_helper"

describe Mashed::Mash do
  let(:mash) { Mashed::Mash.new(a: 1, b: 2, c: 3) }

  describe "#to_hash" do
    it { expect(mash.to_hash).to eq("a" => 1, "b" => 2, "c" => 3) }
  end

  describe "#class" do
    it { expect(mash.class).to be(Mashed::Mash) }
  end

  describe "#methods" do
    it { expect(mash.methods).to eq(["a", "b", "c"]) }
  end

  describe "#delete" do
    before { mash.delete(:a) }
    it { expect(mash.methods).to eq(["b", "c"]) }
  end

  describe "#[]" do
    it { expect(mash[:a]).to eq(1) }
    it { expect(mash["b"]).to eq(2) }
  end

  describe "#method_missing" do
    it {
      expect(mash.a).to eq(1)
      expect(mash.b).to eq(2)
      expect(mash.c).to eq(3)
    }
  end

  describe "wrapping itself" do
    let(:incepted) { Mashed::Mash.new(mash) }
    it { expect(incepted.to_hash).to be_a(Hash) }
  end

  describe "nested hashes" do
    let(:nested) { Mashed::Mash.new(inside: { of: 'you' }) }
    it { expect(nested.inside).to be_a(Mashed::Mash) }
    it { expect(nested.inside.of).to eq('you') }
  end
end
