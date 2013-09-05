require "poker"

include Poker
include Ranks

shared_examples_for Ranks  do |cards, rank_kind, rank_value|
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
end

describe HighCard do
  cards = {diamonds: 3, spades: [5 , 11], clubs: 13, hearts: 9}
  it_behaves_like Ranks, cards, HighCard, RANK_VALUES[:high_card]
end

describe Pair do
  cards = {diamonds: 4, spades: [7, 14], hearts: 4, clubs: 12}
  it_behaves_like Ranks, cards, Pair, RANK_VALUES[:pair]
end

describe TwoPairs do
  cards = {hearts: 5, spades: 8, clubs: 9, diamonds: [8, 5]}
  it_behaves_like Ranks, cards, TwoPairs, RANK_VALUES[:two_pairs]
end

describe ThreeOfAKind do
  cards = {clubs: 12, diamonds: 12, hearts: 12, spades: [3, 8]}
  it_behaves_like Ranks, cards, ThreeOfAKind, RANK_VALUES[:three_of_a_kind]
end
