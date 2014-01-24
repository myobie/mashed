require "spec_helper"

describe Mashed::StringyHash do
  let(:hash) {{ a: 1, b: 2, c: { three: 3 }}}

  describe "#stringify" do
    it { expect(hash.stringify).to eq("a" => 1, "b" => 2, "c" => { "three" => 3 }) }
  end

  describe "get and set" do
    let(:s) { hash.stringify }
    before { s[:a] = "A" }
    it { expect(s[:a]).to eq("A") }
    it { expect(s["a"]).to eq("A") }
  end

  describe "calls to_s on objects" do
    let(:s) { hash.stringify }
    let(:klass) {
      Class.new do
        def to_s; "a"; end
      end
    }
    it { expect(s[klass.new]).to eq(1) }
  end
end
