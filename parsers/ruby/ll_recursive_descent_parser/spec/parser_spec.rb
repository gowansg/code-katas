require "rspec"
require "json_parser"

include Parser 

describe Parser do

  context "when given invalid input" do
    it "raises InvalidTokenError when closing bracket is missing" do
      expect { Parser.parse("{") }.to raise_error(InvalidTokenError)
    end
  end

  it "recognizes empty json" do
    expect(Parser.parse("{}")).to be_true
  end

  context "when parsing objects" do
    it "recognizes an empty object" do
      expect(Parser.parse("{\"test\#{}: {}")).to be_true
    end

    it "recognizes an object with one property" do
      expect(Parser.parse("{\"one\": true}")).to be_true
    end

    it "recognizes an object with more than one property" do
      expect(Parser.parse("{\"one\": \"one\", \"two\": \"two\"}")).to be_true
    end
  end
end