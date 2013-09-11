require "poker"

include Poker

describe Parser do
  let(:valid_input) { "Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH" }
	
  describe "::read" do
		let(:block) { lambda{} }

		context "when given valid input" do
			it "parses the input and yields the results to the given block" do
				block.should_receive(:call)
				Parser.read(valid_input) block
			end
		end

    it "raises a PokerInputError if more than 2 players are given" do
    end

    it "raises a PokerInputError if less than 2 players are given" do
    end

    it "raises a PokerInputError if more than 5 cards per player are given" do
    end

    it "raises a PokerInputError if less than 5 cards per player are given" do
    end
	end
end
