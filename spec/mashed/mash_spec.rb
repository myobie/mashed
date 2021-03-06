require "spec_helper"

describe Mashed::Mash do
  let(:mash) { Mashed::Mash.new(a: 1, b: 2, c: 3) }

  describe "#to_hash" do
    it { expect(mash.to_hash).to eq("a" => 1, "b" => 2, "c" => 3) }
  end

  describe "#class" do
    it { expect(mash.class).to be(Mashed::Mash) }
  end

  describe "#delete" do
    before { mash.delete(:a) }
    it { expect(mash.methods).to include("b", "c") }
  end

  describe "#method_missing" do
    it {
      expect(mash.a).to eq(1)
      expect(mash.b).to eq(2)
      expect(mash.c).to eq(3)
    }

    context "for actual missing keys" do
      it { expect(mash.d).to be_nil }
    end

    context "for methods with an arity > 0 that are not setters" do
      it { expect { mash.something(1) }.to raise_error(StandardError) }
    end

    context "for methods with block" do
      it { expect { mash.map { |k,v| [k,v] } }.to raise_error(StandardError) }
    end
  end

  describe "#method_missing=" do
    before { mash.test = "TEST" }
    it { expect(mash.test).to eq("TEST") }
  end

  describe "#methods" do
    it { expect(mash.methods).to include(:__send__) }
  end

  describe "respond_to?" do
    it { expect(mash.respond_to?(:a)).to be(true) }
    it { expect(mash.respond_to?(:delete)).to be(true) }
    it { expect(mash.respond_to?(:to_hash)).to be(true) }
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

  describe "nested hashed #to_hash" do
    let(:nested) { Mashed::Mash.new(inside: { of: 'you' }) }
    let(:hash)   { nested.to_hash }
    it { expect(hash["inside"]).to be_a(Hash) }
    it { expect(hash["inside"]["of"]).to eq('you') }
  end

  describe "query methods should return booleans" do
    let(:grumpy) { Mashed::Mash.new(yes: "hooray", no: nil) }
    it { expect(grumpy.yes?).to be(true) }
    it { expect(grumpy.yes?).to_not eq("hooray") }
    it { expect(grumpy.no?).to be(false) }
    it { expect(grumpy.no?).to_not be_nil }
  end

  describe "singleton methods" do
    before {
      def mash.something; end
    }
    it { expect(mash.methods).to include(:something) }
  end

  describe "#to_json" do
    it {
      m = double
      expect(mash).to receive(:to_hash).and_return(m)
      expect(m).to receive(:to_json)
      mash.to_json
    }
  end

  context "private methods" do
    describe "#keys" do
      it { expect(mash.__send__(:keys)).to eq(["a", "b", "c"]) }
    end

    describe "#[]" do
      it { expect(mash.__send__(:[],:a)).to eq(1) }
      it { expect(mash.__send__(:[],"b")).to eq(2) }
    end
  end
end
