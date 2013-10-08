require "poker"

include Poker
include Ranks

describe Rank do
  let(:rank) do
    deck = Deck.new
    cards = deck.deal({clubs: 2, hearts: 3, spades:4, diamonds: [4, 3]})
    Rank.new(cards)
  end
  
  it "has a value that is determined by Ranks::RANK_VALUES" do
    expect(rank.value).to eq(RANK_VALUES[:two_pairs])
  end

  it "has a kind which represents the type of rank" do
    expect(rank.kind).to eq(TwoPairs)
  end
end