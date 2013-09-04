module Poker
  class Card
    include Comparable

    attr_reader :suit, :value

    SUITS = [:hearts, :diamonds, :spades, :clubs]
    VALUES = (2..14).to_a
    CARD_NAMES = {
      2 => :two,
      3 => :three,
      4 => :four,
      5 => :five,
      6 => :six,
      7 => :seven,
      8 => :eight,
      9 => :nine,
      10 => :ten,
      11 => :jack,
      12 => :queen,
      13 => :king,
      14 => :ace
    }
      
    def initialize(suit, value)
      raise CardSuitError, 
            "#{suit} is not a valid card suit." unless SUITS.include?(suit) 
      raise CardValueError,
            "#{value} is not a valid card value." unless VALUES.include?(value)

      @suit = suit
      @value = value
    end

    def to_s
      "#{CARD_NAMES[@value]} of #{@suit}"
    end

    def <=>(other)
      @value <=> other.value
    end

    def ==(other)
      @value == other.value && @suit == other.suit
    end
  end
end