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

  it "groups the cards by value in descending order" do
     cards = Deck.new.deal({spades: [5,3], hearts:  [5, 3], clubs: 2 })
     hand = Hand.new(cards)
     expect(hand.cards).to (eq [ 
                                Card.new(:spades, 5), 
                                Card.new(:hearts, 5),
                                Card.new(:spades, 3), 
                                Card.new(:hearts, 3),
                                Card.new(:clubs, 2)
                            ])
   end
end