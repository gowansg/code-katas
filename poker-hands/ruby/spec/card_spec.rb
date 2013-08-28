require_relative "../lib/card"

describe Poker::Card do
  let(:card) { Poker::Card.new(13, :diamond) }

  it "has a suit" do
    expect(card.suit).to eql(:diamond)
  end

  it "has a value" do
    expect(card.value).to eql(13)
  end
end