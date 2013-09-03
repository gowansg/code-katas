require "poker"

include Poker

describe Hand do
  let(:hand) do 
    cards = []
    deck = Deck.new
    7.times { cards << deck.deal }
    Hand.new(cards)
  end

  it "has exactly 5 cards" do
    expect(hand.cards.length).to eql(5)
  end

  it "has a rank" do
    expect(hand.rank).to be_true
  end
end