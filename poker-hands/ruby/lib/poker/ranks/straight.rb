module Poker
  module Ranks
    module Straight
      extend self

      def value
        RANK_VALUES[:straight]
      end

      def match?(cards)
        values = cards.collect { |c| c.value }
        return true if values.sequential?
        if values[0] == 14 && values.sequential?(1, 4)
          cards = cards.push(cards[0]).drop(1)
        end
      end
    end
  end
end