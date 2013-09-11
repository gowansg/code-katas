module Poker
	class Parser
    
    CHAR_TO_SUITS = {
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
    
    def self.read(line)
      game_input = line.split(" ")
      raise PokerInputError, 
        "The input: \"#{line}\" is not valid." unless game_info.length == 10
      
      game = Hash[game_input]
      game.keys.each { |k|  k.slice!(k.length - 1) if k.end_with?(":") }
      game.values.collect { |v| create_cards_hash(v) }
      yield game
    end

    def create_card_hash(input)
      values = input.split(" ")
      cards = {}
      values.each do |card|
        suit = CHAR_TO_SUIT[card[1]]
        raise PokerInputError,
          "\"#{suit}\" is not a recognized card suit" unless suit

        value = input[0].to_i unless CHAR_TO_VALUE[card[0]]
        raise PokerInputError,
          "\"#{value}\" is not a recognized card value" unless value

        curr_val = card[suit]
        if curr_val.nil?
          card[suit] = value
        elsif curr_val.respond_to(:<<)
          card[suit] << value
        else
          card[suit] = [curr_val, value]
        end
      end
    end
	end
end