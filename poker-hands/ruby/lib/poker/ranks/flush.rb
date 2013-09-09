module Poker
  module Ranks
    module Flush
      extend self

      def value
        RANK_VALUES[:flush]
      end

      def match?(cards)
        cards.group_by { |c| c.suit }.count == 1
      end
    end
  end
end