module Poker
  class Deck

    def initialize
      card_values = (2..9).to_a + %w(T J Q K A)
      suits = [:diamonds, :hearts, :spades, :clubs]
      @cards = {}
      suits.each do |s| 
        card_values.each { |v| @cards[Poker::Card.new(s, v)] = 0 }
      end
    end

    def deal(*cards)
      return random_card if cards.empty?
    end

    def shuffle!
      @cards.each_value { |v| v = 0 }
    end

    def random_card()
      keys = @cards.keys
      key = keys[rand(0..keys.length)]
      card = @cards[key]
    end
  end
end