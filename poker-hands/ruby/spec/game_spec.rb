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

      # http://codingdojo.org/cgi-bin/wiki.pl?KataPokerHands
      it "passes all the test cases given on the website" do
        scenarios = {
          "Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH" => 
            "White wins. - with high card: Ace",

          "Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S" => 
            "Black wins. - with full house",

          "Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C KH" => 
            "Black wins. - with high card: 9",

          "Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH" => "Tie."
        }

        scenarios.keys.each do |s|
          result = Game.simulate do
            num_of_players 2
            hand_size 5
            scenario s
          end

          expect(result).to eq(scenarios[s])
        end
      end
    end
  end
end