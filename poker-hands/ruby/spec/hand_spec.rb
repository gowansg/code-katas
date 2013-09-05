require "poker"

include Poker

describe Hand do
  let(:random_hand) do 
    deck = Deck.new
    cards = 5.times.collect { deck.deal }
    Hand.new(cards)
  end
   
  it "has a rank" do
    expect(random_hand.rank).to be_true
  end

  # it "sorts the cards from highest rank to lowest" do
  #   cards = Deck.new.deal({spades: [5,3], hearts:  })
  # end
end