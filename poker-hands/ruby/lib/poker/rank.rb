module Poker
  class Rank
    attr_reader :value, :high_card, :kind

    def initialize(cards)
      rank(cards)
    end

    private

    def rank(cards)
      ranks = Ranks.constants
                   .collect { |const| Ranks.const_get(const) }
                   .select {  |c| c.class == Module }
                   .sort {|c| c.value }

      kind = ranks.find { |r| r.match?(cards) }
      @value = kind.value
      @high_card = kind.high_card
      @kind = kind
    end
  end
end