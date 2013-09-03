module Poker
  module Ranks
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
  end
end