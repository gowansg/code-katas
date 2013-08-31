module Poker
  class Card
    include Comparable
    attr_reader :suit, :value

    def initialize(suit, value)
      raise CardSuitError, 
            "#{suit} is not a valid card suit." unless SUITS.include?(suit) 
      raise CardValueError,
            "#{value} is not a valid card value." unless VALUES.include?(value)
            
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

    private
    
    SUITS = [:hearts, :diamonds, :spades, :clubs]
    VALUES = (2..14).to_a
  end
end