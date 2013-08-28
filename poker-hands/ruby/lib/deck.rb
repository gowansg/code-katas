module Poker
  class Deck

    def deal(*cards)

    end

    private
      default_values = {}
      (2..14).each { |c| default_values[c] = 0 }
      
      DECK = {
        diamonds: default_values,
        hearts:  default_values,
        spades: default_values,
        clubs: default_values
      }
  end
end