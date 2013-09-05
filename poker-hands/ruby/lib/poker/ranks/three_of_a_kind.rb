module Poker
  module Ranks
    module ThreeOfAKind
      extend self

      def value
        RANK_VALUES[:three_of_a_kind]
      end

      def match?(cards)
        Ranks.find_repeating_values(cards.collect { |c| c.value }, 3)
      end
    end
  end
end