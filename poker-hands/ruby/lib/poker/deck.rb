module Poker
  class Deck
    include Poker

    def initialize
      card_values = (2..14).to_a
      suits = [:diamonds, :hearts, :spades, :clubs]
      @cards = []
      suits.each do |s| 
        card_values.each { |v| @cards << Card.new(s, v) }
      end
    end

    def deal(requested_cards={})
      return random_card if requested_cards.empty?
      
      cards = requested_cards.collect do |k, v| 
        if v.respond_to?(:collect) 
          v.collect { |x| Card.new(k, x) }
        else
          Card.new(k, v)
        end
      end.flatten

      cards.each do |c|
        raise Poker::CardAlreadyDealtError, 
                "#{c.to_s} has already been dealt" unless @cards.delete(c)
      end
    end

    def place_in_deck(*cards)
      cards.each { |c| @cards << c if !@cards.include?(c) && c.is_a?(Card) }
    end

    private

    def random_card
      @cards.delete_at(rand(0...@cards.length))
    end
  end
end