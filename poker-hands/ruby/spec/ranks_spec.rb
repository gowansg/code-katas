require "poker"

include Poker
include Ranks

shared_examples_for Ranks  do |cards, rank_kind, rank_value, high_cards|
  let(:rank) do 
    deck = Deck.new
    Hand.new(deck.deal(cards)).rank
  end
  
  it "matches a hand that doesn't match any other rank" do
    expect(rank.kind).to eq(rank_kind)
  end

  it "has a value" do
    expect(rank.value).to eq(rank_value)
  end

  it "has high cards" do
    expect(rank.high_cards).to eq(high_cards)
  end
end

describe HighCard do
  cards = {diamonds: 3, spades: [5 , 11], clubs: 13, hearts: 9}
  high_cards = [13, 11, 9, 5, 3]
  it_behaves_like Ranks, cards, HighCard, RANK_VALUES[:high_card], high_cards
end

describe Pair do
  cards = {diamonds: 4, spades: [7, 14], hearts: 4, clubs: 12}
  high_cards = [4, 14, 12, 7]
  it_behaves_like Ranks, cards, Pair, RANK_VALUES[:pair], high_cards
end

describe TwoPairs do
  cards = {hearts: 5, spades: 8, clubs: 9, diamonds: [8, 5]}
  high_cards = [8, 5, 9]
  it_behaves_like Ranks, cards, TwoPairs, RANK_VALUES[:two_pairs], high_cards
end
