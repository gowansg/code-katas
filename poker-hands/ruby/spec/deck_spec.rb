require_relative "../lib/deck"

describe Poker::Deck do
  let(:deck) { Poker::Deck.new }

  describe "#deal(*cards)" do
    context "when no input is given" do
      it "returns a random card that has not yet been dealt" do
        card = deck.deal
        another_card = deck.deal
        expect(card).to not_eql(another_card)
      end
    end

    context "when a card has already been dealt" do
      it "raises a card already dealt error" do
        card = deck.deal("5C")
        expect(deck.deal("5C")).to raise_error Poker:Errors::CardAlreadyDealt
      end
    end
  end
end