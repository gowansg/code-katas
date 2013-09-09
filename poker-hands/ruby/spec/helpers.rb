require "poker"

module Helpers
  module Cards
    include Poker

    def straight_flush
      cards = {spades: [3,2,4,14,5]}
      Deck.new.deal(cards)
    end

    def four_of_a_kind
      cards = {diamonds: 12, clubs: [4, 12], hearts: 12, spades: 12}
      Deck.new.deal(cards)
    end

    def full_house
      cards = {hearts: 12, clubs: 9, spades: [12, 9], diamonds: 12}
      Deck.new.deal(cards)
    end

    def flush
      cards = {diamonds: [10, 5, 3, 14, 2]}
      Deck.new.deal(cards)
    end

    def straight
      cards = {spades: [7, 8], clubs: 5, diamonds: [6, 4]}
      Deck.new.deal(cards)
    end

    def three_of_a_kind
      cards = {clubs: 12, diamonds: 12, hearts: 12, spades: [3, 8]}
      Deck.new.deal(cards)
    end

    def two_pairs
      cards = {hearts: 5, spades: 8, clubs: 9, diamonds: [8, 5]}
      Deck.new.deal(cards)
    end

    def pair
      cards = {diamonds: 4, spades: [7, 14], hearts: 4, clubs: 12}
      Deck.new.deal(cards)
    end

    def high_card
      cards = {diamonds: 3, spades: [5 , 11], clubs: 13, hearts: 9}
      Deck.new.deal(cards)
    end
  end
end