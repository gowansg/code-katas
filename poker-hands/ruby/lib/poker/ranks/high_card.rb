module Poker
  module Ranks
    module HighCard
      extend self

      def value
        RANK_VALUES[:high_card]
      end

      def match?(cards)
        true
      end
    end
  end
end