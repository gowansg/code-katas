module Poker
  class Hand
    attr_reader :cards

    def initialize(cards)
      @cards = cards.take(5).sort
    end

    def rank
      return @rank if @rank

    end
  end
end