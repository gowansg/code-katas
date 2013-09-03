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

    protected
    
    def self.high_cards(cards)
      cards.collect { |c| c.value }.reverse
    end

    module HighCard
      extend self

      def match?(cards)
        @cards = cards
        true
      end

      def value
        RANK_VALUES[:high_card]
      end

      def high_cards
        Ranks.high_cards(@cards)
      end
    end

    module Pair
      extend self

      def match?(cards)
        @cards = cards
        @cards.each_index do |i| 
          break if @cards.length - 1 == i
          if @cards[i].value == @cards[i + 1].value
            @pair = @cards[i].value
            break
          end
        end
        !@pair.nil?
      end

      def value
        RANK_VALUES[:pair]
      end

      def high_cards
        Ranks.high_cards(@cards).unshift(@pair).uniq
      end
    end

    module TwoPairs
      extend self

      def match?(cards)
      end

      def value
        RANK_VALUES[:two_pairs]
      end

      def high_cards
        Ranks.high_cards(@cards)
      end
    end
  end
end