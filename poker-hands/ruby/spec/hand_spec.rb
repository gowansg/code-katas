require_relative "../lib/hand"

describe Poker::Hand do
  let(:hand) { Poker::Hand.new(%w(2C 3D 5S 9C KD)) }

  it "has exactly 5 cards" do
    expect(hand.cards.length).to eql(5)
  end

  it "has a rank" do
    expect(hand.rank).to be_true
  end
end