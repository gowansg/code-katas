module Poker
  class Card
    attr_reader :suit, :value

    def initialize(suit, value)
      @suit = suit
      @value = value
    end

    def to_s
      "#{@value} of #{@suit}"
    end
  end
end