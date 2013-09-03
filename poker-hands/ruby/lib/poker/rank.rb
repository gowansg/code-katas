module Poker
  class Rank
    attr_reader :value, :high_cards, :kind

    def initialize(cards)
      rank(cards)
    end

    private

    def rank(cards)
      ranks = Ranks.constants
                   .collect { |const| Ranks.const_get(const) }
                   .select {  |c| c.class == Module }
                   .sort {|x,y| y.value <=> x.value }

      kind = ranks.find { |r| r.match?(cards) }
      @value = kind.value
      @high_cards = kind.high_cards
      @kind = kind
    end
  end
end