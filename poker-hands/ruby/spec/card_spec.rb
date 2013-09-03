require "poker"

include Poker

describe Card do
  let(:card) { Card.new(:diamonds, 13) }

  it "has a suit" do
    expect(card.suit).to eql(:diamonds)
  end

  it "has a value" do
    expect(card.value).to eql(13)
  end
end