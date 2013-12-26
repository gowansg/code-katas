module Poker
  module Parser
    
    CHAR_TO_SUIT = {
      "H" => :hearts, 
      "D" => :diamonds, 
      "S" => :spades, 
      "C" => :clubs
    }

    CHAR_TO_VALUE = {
      "T" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14
    }
    
    def read(line)
      game_input = line.split("  ").collect do |i| 
        i.split(":").collect { |v| v.strip }
      end

      game = Hash[game_input]
      game.keys.each { |k| game[k] = create_cards_hash(game[k].split(" ")) }
      game
    end

    private 

    def create_cards_hash(values)
      cards = {}

      values.each do |card|
        suit = CHAR_TO_SUIT[card[1]]
        raise PokerInputError,
          "\"#{card[1]}\" is not a recognized card suit" unless suit

        value = CHAR_TO_VALUE[card[0]] || card[0].to_i
        raise PokerInputError,
          "\"#{card[0]}\" is not a recognized card value" unless value

        curr_val = cards[suit]
        if curr_val.nil?
          cards[suit] = value
        elsif curr_val.respond_to?(:shift)
          cards[suit] = curr_val.shift(value)
        else
          cards[suit] = [curr_val, value]
        end
      end

      cards
    end
  end
end