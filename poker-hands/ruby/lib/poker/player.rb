module Poker
  class Player
    attr_reader :name, :hand

    def initialize(name, hand)
      @name = name
      @hand = hand
    end
  end
end