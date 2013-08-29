module Poker
  class Deck
    def initialize
      card_values = (2..14).to_a
      suits = [:diamonds, :hearts, :spades, :clubs]
      @cards = []
      suits.each do |s| 
        card_values.each { |v| @cards << Poker::Card.new(s, v) }
      end
    end

    def deal(*cards)
      return random_card if cards.empty?
      
      cards.each do |c|
        raise Poker::CardAlreadyDealtError, 
                "#{c.to_s} has already been dealt" unless @cards.delete(c)
      end
    end

    def add_to_deck(*cards)
      cards.each { |c| @cards << c unless @cards.include?(c) }
    end

    def random_card()
      @cards.delete_at(rand(0...@cards.length))
    end
  end
end