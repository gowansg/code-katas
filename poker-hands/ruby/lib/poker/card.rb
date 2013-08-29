module Poker
  class Card
    include Comparable
    attr_reader :suit, :value

    def initialize(suit, value)
      @suit = suit
      @value = value
    end

    def to_s
      "#{@value} of #{@suit}"
    end

    def <=>(other)
      @value <=> other.value
    end

    def ==(other)
      @value == other.value && @suit == other.suit
    end
  end
end