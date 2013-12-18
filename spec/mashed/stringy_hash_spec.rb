require "spec_helper"

describe Mashed::StringyHash do
  let(:hash) {{ a: 1, b: 2, c: { three: 3 }}}

  describe "#stringify" do
    it { expect(hash.stringify).to eq("a" => 1, "b" => 2, "c" => { "three" => 3 }) }
  end
end
