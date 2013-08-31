module Poker
  class Rank
    attr_reader :value, :high_card, :kind

    def initialize(hand)
      rank(hand)
    end

    private
    
    def rank(hand)
      ranks = Ranks.constants
                   .collect { |const| Ranks.const_get(const) }
                   .select {  |c| c.class == Module }

      kind = ranks.find { |r| r.match?(hand) }
      @value = kind.value
      @high_card = kind.high_card
      @kind = kind
    end
  end
end