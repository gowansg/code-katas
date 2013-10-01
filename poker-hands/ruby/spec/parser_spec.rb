require "poker"

include Poker
include Parser

describe Parser do
  describe "#read" do
    let(:valid_input) { "Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH" }
    let(:invalid_suit) { valid_input.gsub!(/3D/, "3E") }
    let(:invalid_value) { valid_input.gsub!(/3D/, "1E") }
    
    let(:black_hand) do 
      {"Black" => {hearts: 2, diamonds: [3, 13], spades: 5, clubs: 9}} 
    end

    let(:white_hand) do
      {"White" => {clubs: [2, 8], hearts: [3, 14], spades: 4}}
    end
		context "when given valid input" do
			it "returns a Hash of player names and cards" do
        expect(Parser.read(valid_input)).to eq(black_hand.merge(white_hand))
			end
		end

    context "when given invalid input" do
      it "raises a PokerInputError for an invalid card suit" do
        expect { Parser.read(invalid_suit) }.to raise_error(PokerInputError)
      end

      it "raises a PokerInputError for an invalid card value" do
        expect { Parser.read(invalid_value) }.to raise_error(PokerInputError)
      end
    end
  end
end
