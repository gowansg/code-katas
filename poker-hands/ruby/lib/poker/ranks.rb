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
    
    def self.high_cards(cards)
      cards.collect { |c| c.value }.reverse
    end

    #returns the index of the element at the start of a repeating series
    def self.find_repeating_values(enum, num_of_repeats)
      enum.each_index do |i|
        return nil if i + num_of_repeats > enum.length
        return i if enum[i...(i+num_of_repeats)].all? { |v| v == enum[i] }
      end
    end
  end
end

require "poker/ranks/high_card"
require "poker/ranks/pair"
require "poker/ranks/two_pairs"
require "poker/ranks/three_of_a_kind"