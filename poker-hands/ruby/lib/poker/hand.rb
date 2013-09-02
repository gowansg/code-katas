module Poker
  class Hand
    include Poker
    attr_reader :cards

    def initialize(cards)
      @cards = cards.take(5).sort
    end

    def rank
      @rank ||= Rank.new(@cards)
    end
  end
end