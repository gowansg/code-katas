require "poker"

include Poker

describe Deck do
  let(:deck) { Deck.new }

  describe "#deal(*cards)" do
    context "when no input is given" do
      it "returns a random card that has not yet been dealt" do
        card = deck.deal
        another_card = deck.deal
        expect(card).not_to eq(another_card)
      end
    end

    context "when a card has already been dealt" do
      it "raises a card already dealt error" do
        card = {spades: 2}
        deck.deal(card)
        expect { deck.deal(card) }.to raise_error(CardAlreadyDealtError)
      end
    end
  end
end