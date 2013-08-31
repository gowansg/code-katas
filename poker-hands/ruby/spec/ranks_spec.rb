require_relative '../lib/poker'
include Poker

describe Ranks do
  describe Ranks::HighCard do
    let(:hand) do 
      deck = Deck.new
      cards = {diamonds: 3, spades: 5, clubs: 13, hearts: 9, spades: 11}
      Hand.new(deck.deal(cards))
    end
    
    it "matches a hand that doesn't match any other rank" do

    end

    it "has a value" do

    end

    it "has a high card" do

    end
  end

  describe Ranks::Pair do

  end
end