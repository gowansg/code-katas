module Poker
  class CardAlreadyDealtError < StandardError; end
  class CardSuitError < StandardError; end
  class CardValueError < StandardError; end
  class PokerInputError < StandardError; end
end