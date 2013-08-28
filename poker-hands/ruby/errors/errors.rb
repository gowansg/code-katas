module Errors
  class CardAlreadyDealtError < StandardError
    def initialize(card)
      @message = "#{card} has already been dealt"
    end
  end
end