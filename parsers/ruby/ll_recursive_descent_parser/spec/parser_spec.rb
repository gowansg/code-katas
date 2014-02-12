require "rspec"
require "json_parser"

include Parser 

describe Parser do
  context "when parsing properly escaped strings" do
    it "parses backslashes" do
      expect(Parser.parse(%<{"\\\\": true}>)).to be_true
    end

    it "parses unicode hex-digits" do
      expect(Parser.parse(%<["\\uF4A9"]>)).to be_true
    end

    it "parses a backspace" do
      expect(Parser.parse(%<["\\b"]>)).to be_true
    end

    it "parses a slash" do
      expect(Parser.parse(%<["\\/"]>)).to be_true
    end
  end

  context "when parsing objects" do
    it "parses empty json" do
      expect(Parser.parse("{}")).to be_true
    end

    it "parses an empty object property" do
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

    it "parses a string" do
      expect(Parser.parse(%<["a nice simple string"]>)).to be_true
    end

    it "parses an integer" do
      expect(Parser.parse("[1]")).to be_true
    end

    it "parses a negative number" do
      expect(Parser.parse("[-2]")).to be_true
    end
  end

  context "when parsing literals" do
    it "parses true" do
      expect(Parser.parse("[true]")).to be_true
      expect(Parser.parse(%<{"a": true}>)).to be_true
    end

    it "parses false" do
      expect(Parser.parse("[false]")).to be_true
      expect(Parser.parse(%<{"test": false}>)).to be_true
    end

    it "parses a null" do
      expect(Parser.parse("[null]")).to be_true
      expect(Parser.parse(%<{"property": null}>)).to be_true
    end
  end

  context "when parsing scientific notation" do
    it "parses an integer" do
      expect(Parser.parse("[1e2]"))
      expect(Parser.parse("[1E2]"))
    end

    it "parses a fraction" do
      expect(Parser.parse("[2.32e23]"))
      expect(Parser.parse("[2.32E23]"))
    end

    it "parses when a positive sign is included" do
      expect(Parser.parse("[2e+3]"))
      expect(Parser.parse("[2E+3]"))
    end

    it "parses when a negative sign is included" do
      expect(Parser.parse("[6.23e-0]"))
      expect(Parser.parse("[6.23E-0]"))
    end
  end

  context "when an InvalidTokenError is raised it's because the input" do
    it "is missing a closing bracket" do
      expect { Parser.parse("{") }.to raise_error(InvalidTokenError)
    end

    it "has object properties missing quote marks" do
      expect { Parser.parse("{fail: true}") }.to raise_error(InvalidTokenError)
    end

    it "has unescaped backslashes" do
      expect { Parser.parse(%<{"\\": false}>)}.to raise_error(InvalidTokenError)
    end

    it "has fractions without a digit before the decimal" do
      expect { Parser.parse("[.22]")}.to raise_error(InvalidTokenError)
    end
  end

  context "when an InvalidUnicodeEscapeError is raise it's because the input" do
    it "has non-hex-digits following a unicode escape" do
      json = %<["\\u2v23"]>
      expect { Parser.parse(json) }.to raise_error(InvalidUnicodeEscapeError)
    end
  end
end