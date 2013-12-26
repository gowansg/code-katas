module Poker
  class Hand
    include Comparable

    attr_reader :cards

    def initialize(cards)
      sort_hand(cards)
    end

    def rank
      @rank ||= Rank.new(@cards)
    end

    def sort_hand(cards)
      @cards ||= cards.group_by { |c| c.value }
                      .sort do |i1, i2| 
                        same_length = i1[1].length == i2[1].length
                        value1 = same_length ? i1[0] : i1[1].length
                        value2 = same_length ? i2[0] : i2[1].length
                        value2 <=> value1
                      end
                      .collect { |c| c[1] }
                      .flatten
    end

    def <=>(other)
      comparison = rank.value <=> other.rank.value
      return comparison unless comparison == 0
      @cards <=> other.cards
    end

    def ==(other)
      rank.kind == other.rank.kind
    end
  end
end