require "rspec"
require "json_parser"

include Parser 

describe Parser do
  it "parses empty json" do
    expect(Parser.parse("{}")).to be_true
  end

  context "when parsing objects" do
    it "parses an empty object" do
      expect(Parser.parse("{\"test\": {}}")).to be_true
    end

    it "parses an object with one property" do
      expect(Parser.parse("{\"one\": true}")).to be_true
    end

    it "parses an object with more than one property" do
      expect(Parser.parse("{\"one\": \"one\", \"two\": \"two\"}")).to be_true
    end

    it "parses nested objects" do
      json = "{
                \"firstObject\": {
                  \"secondObject\": { 
                    \"thirdObject\": []
                  }
                }
              }"
      expect(Parser.parse(json)).to be_true
    end
  end

  context "when parsing arrays" do
    it "parses an empty array" do
      expect(Parser.parse("[]")).to be_true
    end

    it "parses multi-dimensional arrays" do
      expect(Parser.parse("[[[]]]")).to be_true
    end
  end

  context "when an InvalidTokenError is raised it's because the input" do
    it "is missing a closing bracket" do
      expect { Parser.parse("{") }.to raise_error(InvalidTokenError)
    end

    it "has object properties missing quote marks" do
      expect do
        Parser.parse("{ invalid: true }") 
      end.to raise_error(InvalidTokenError)
    end
  end
end