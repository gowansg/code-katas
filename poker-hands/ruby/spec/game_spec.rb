require "poker"

include Poker

describe Game do
  describe "::simulate" do
    context "when given valid input" do
      it "declares a winner if there isn't a tie" do
        result = Game.simulate do
          num_of_players 2
          hand_size 5
          scenario "Black: AH AC AS 9S AD  White: 2S 4D TH 3C JC"
        end
        
        expect(result).to eq("Black wins. - with four of a kind")
      end

      it "declares a tie if there is no winner" do
        result = Game.simulate do
          num_of_players 2
          hand_size 5
          scenario "Black: 2H 3C 4S 5S 6D  White: 2S 3D 4H 5C 6C"
        end

        expect(result).to eq("Tie.")
      end
    end
  end
end