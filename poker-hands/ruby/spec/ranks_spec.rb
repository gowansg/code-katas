require_relative '../lib/poker'
include Poker
include Ranks

shared_examples_for Ranks  do |cards, rank_kind, rank_value, high_card|
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

  it "has a high card" do
    expect(rank.high_card).to eq(high_card)
  end
end

describe HighCard do
  cards = { diamonds: 3, spades: [5 , 11], clubs: 13, hearts: 9 }
  it_behaves_like Ranks, 
                  cards, 
                  HighCard, 
                  RANK_VALUES[:high_card],
                  Card.new(:clubs, 13) 
end

describe Ranks::Pair do
  cards = { diamonds: 4, spades: [7, 14], hearts: 4, clubs: 12 }
  it_behaves_like Ranks,
                  cards,
                  Pair,
                  RANK_VALUES[:pair],
                  Card.new(:spades, 14)
end
