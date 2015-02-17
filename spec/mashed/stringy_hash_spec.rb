require "spec_helper"

describe Mashed::StringyHash do
  let(:hash) {{ a: 1, b: 2, c: { three: 3 }, d: [:e, { f: 4 }]}}

  def stringify
    Mashed::StringyHash.stringify(hash)
  end

  describe ".stringify" do
    it {
      expect(stringify).to eq({
        "a" => 1,
        "b" => 2,
        "c" => { "three" => 3 },
        "d" => [:e, { "f" => 4 }]
      })
    }
  end

  describe "get and set" do
    let(:s) { stringify }
    before { s[:a] = "A" }
    it { expect(s[:a]).to eq("A") }
    it { expect(s["a"]).to eq("A") }
    it { expect(s.key?(:a)).to be(true) }
    it { expect(s.key?("a")).to be(true) }
  end

  describe "calls to_s on objects" do
    let(:s) { stringify }
    let(:klass) {
      Class.new do
        def to_s; "a"; end
      end
    }
    it { expect(s[klass.new]).to eq(1) }
  end

  describe "#merge" do
    it { expect(stringify.merge({hello: "world"})).to include("hello"=>"world") }
  end
end
