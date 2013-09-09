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
  end
end

require "poker/ranks/high_card"
require "poker/ranks/pair"
require "poker/ranks/two_pairs"
require "poker/ranks/three_of_a_kind"
require "poker/ranks/straight"
require "poker/ranks/flush"
require "poker/ranks/full_house"
require "poker/ranks/four_of_a_kind"
require "poker/ranks/straight_flush"