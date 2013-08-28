require_relative "../lib/game"

describe Poker::Game do
  describe ".simulate" do
    it "returns a winner" do
      winner = Poker::Game.simulate do
        players []
        hands []
      end
      expect(winner).to be_true
    end
  end
end