module Poker
  class Rank

    attr_reader :value, :kind

    def initialize(cards)
      rank(cards)
    end

    private

    def rank(cards)
      rank = Ranks.constants
                   .collect { |const| Ranks.const_get(const) }
                   .select {  |c| c.class == Module }
                   .sort { |x,y| y.value <=> x.value }
                   .find { |r| r.match?(cards) }

      @value = rank.value
      @kind = rank
    end
  end
end