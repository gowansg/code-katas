require_relative "../lib/poker"

describe Poker::Hand do
  let(:hand) do 
    cards = []
    deck = Poker::Deck.new
    5.times { cards << deck.deal }
    Poker::Hand.new(cards)
  end

  it "has exactly 5 cards" do
    expect(hand.cards.length).to eql(5)
  end

  it "has a rank" do
    expect(hand.rank).to be_true
  end
end