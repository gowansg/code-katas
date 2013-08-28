module Poker
  class Card
    attr_reader :value, :suit

    def initialize(value, suit)
      @value = value
      @suit = suit
    end
  end
end