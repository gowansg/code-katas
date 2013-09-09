module Poker
  module Ranks
    module StraightFlush
      extend self

      def value
        RANK_VALUES[:straight_flush]
      end

      def match?(cards)
        Straight.match?(cards) && Flush.match?(cards)
      end
    end
  end
end