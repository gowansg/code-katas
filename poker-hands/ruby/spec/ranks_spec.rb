require "poker"

include Poker
include Ranks
include Helpers::Cards

shared_examples_for Ranks  do |cards, rank_kind, rank_value|
  let(:rank) do 
    Hand.new(cards).rank
  end
  
  it "matches a hand that doesn't match any other rank" do
    expect(rank.kind).to eq(rank_kind)
  end

  it "has a value" do
    expect(rank.value).to eq(rank_value)
  end
end

describe HighCard do
  cards = high_card
  it_behaves_like Ranks, cards, HighCard, RANK_VALUES[:high_card]
end

describe Pair do
  cards = pair
  it_behaves_like Ranks, cards, Pair, RANK_VALUES[:pair]
end

describe TwoPairs do
  cards = two_pairs
  it_behaves_like Ranks, cards, TwoPairs, RANK_VALUES[:two_pairs]
end

describe ThreeOfAKind do
  cards = three_of_a_kind
  it_behaves_like Ranks, cards, ThreeOfAKind, RANK_VALUES[:three_of_a_kind]
end

describe Straight do
  cards = straight
  it_behaves_like Ranks, cards, Straight, RANK_VALUES[:straight]
end

describe Flush do
  cards = flush
  it_behaves_like Ranks, cards, Flush, RANK_VALUES[:flush]
end

describe FullHouse do
  cards = full_house
  it_behaves_like Ranks, cards, FullHouse, RANK_VALUES[:full_house]
end

describe FourOfAKind do
  cards = four_of_a_kind
  it_behaves_like Ranks, cards, FourOfAKind, RANK_VALUES[:four_of_a_kind]
end

describe StraightFlush do
  cards = straight_flush
  it_behaves_like Ranks, cards, StraightFlush, RANK_VALUES[:straight_flush]
end
