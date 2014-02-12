module Parser
  extend self
  
  LEFT_CURLY_BRACE = "{"
  RIGHT_CURLY_BRACE = "}"
  LEFT_SQUARE_BRACE = "["
  RIGHT_SQUARE_BRACE = "]"
  COLON = ":"
  QUOTE = "\""
  COMMA = ","
  T = "t"
  F = "f"
  N = "n"
  U = "u"
  TRUE = "true"
  FALSE = "false"
  NULL = "null"
  NEGATIVE_SIGN = "-"
  POSITIVE_SIGN = "+"
  DECIMAL = "."
  ESCAPE = "\\"
  EOF = nil

  def parse(input) 
    @input = input
    @current_index = 0
    consume
    json?
  end

  private
  
  def match(token)
    raise InvalidTokenError, 
          %<Encountered: "#{@current}", Expected: "#{token}" at index 
          #{@current_index}> unless @current == token
    consume
  end

  def consume
    return @current = EOF if @current_index > (@input.length - 1)
  
    @current = @input[@current_index]
    @current_index += 1
    consume if white_space?
  end

  def json?
    if @current == LEFT_CURLY_BRACE
      object
    else
      array
    end
    match(EOF)
    true
  end

  def object
    match(LEFT_CURLY_BRACE) 
    name_value_pairs unless @current == RIGHT_CURLY_BRACE
    match(RIGHT_CURLY_BRACE)
  end

  def name_value_pairs
    string
    match(COLON)
    value
    while @current == COMMA
      match(COMMA)
      name_value_pairs
    end
  end

  def array
    match(LEFT_SQUARE_BRACE)
    value unless @current == RIGHT_SQUARE_BRACE
    while @current == COMMA
      match(COMMA)
      value
    end
    match(RIGHT_SQUARE_BRACE)
  end

  def value
    case @current
    when LEFT_CURLY_BRACE
      object
    when LEFT_SQUARE_BRACE
      array
    when QUOTE
      string
    when T
      true_literal
    when F
      false_literal
    when N
      null_literal
    else
      number
    end
  end

  def string
    match(QUOTE)
    while @current != QUOTE
      consume if valid_character?
      escape if @current == ESCAPE
    end
    match(QUOTE)
  end

  def escape
    match(ESCAPE)
    if @current == U
      unicode
    elsif escape_character?
      consume
    end
  end

  def unicode
    match(U)
    4.times { hex_digit }
  end

  def hex_digit
    raise InvalidUnicodeEscapeError, 
          %<"#{@current}" is not a valid hexadecimal digit> unless hex_digit?
    consume
  end

  def true_literal
    TRUE.each_char { |c| match(c) }
  end

  def false_literal
    FALSE.each_char { |c| match(c) }
  end

  def null_literal
    NULL.each_char { |c| match(c) }
  end

  def number
    match(NEGATIVE_SIGN) if @current == NEGATIVE_SIGN
    
    raise InvalidTokenError, 
          %<Encountered: "#{@current}", Expected digit"> unless digit?

    consume while digit?
    match(DECIMAL) if @current == DECIMAL
    consume while digit?
    scientific_notation
    consume while digit?
  end

  def scientific_notation
    return unless scientific_notation?
    consume
    if @current == POSITIVE_SIGN
      match(POSITIVE_SIGN)
    elsif @current == NEGATIVE_SIGN
      match(NEGATIVE_SIGN)
    end
  end

  def scientific_notation?
    match?(/[eE]/, "an e or an E")
  end

  def white_space?
    match?(/\s/, "a white space character")
  end

  def valid_character?
    match?(/[^\\"]/, "a non-escape character")
  end

  def escape_character?
    match?(/[\s\"u\/\\]/, "an escape character")
  end

  def hex_digit?
    digit? || match?(/[a-f]/i, "a hexadecimal digit")
  end

  def digit?
    match?(/\d/, "digit")
  end

  def eof?
    @current == EOF
  end

  def match?(regex, expected)
    raise InvalidTokenError, 
          %<Encountered: "EOF", expected: "#{expected}"> if eof?
    @current.match(regex)
  end
end