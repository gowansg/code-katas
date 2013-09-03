module Poker
  module Ranks
    RANK_VALUES = { 
      high_card: 1,
      pair: 2, 
      two_pairs: 3, 
      three_of_a_kind: 4,
      straight: 5,
      flush: 6,
      full_house: 7,
      four_of_a_kind: 8,
      straight_flush: 9 
    }

    module HighCard
      extend self

      def match?(cards)
        @cards = cards
        true
      end

      def value
        RANK_VALUES[:high_card]
      end

      def high_card
        @cards.reverse
      end
    end

    module Pair
      extend self

      def match?(cards)
        @cards = cards
        @pair = nil
        @cards.each_index do |i| 
          break if @pair || @cards.length - 1 == i
          if @cards[i] == @cards[i + 1]
            @pair = @cards[i] 
            @cards.slice!(i, i+1)
          end
        end
      end

      def value
        RANK_VALUES[:pair]
      end

      def high_card
        @card.reverse.unshift(@pair)
      end
    end

    module TwoPairs
      extend self

      def match?(cards)
      end

      def value
        RANK_VALUES[:two_pairs]
      end

      def high_card
      end
    end
  end
end