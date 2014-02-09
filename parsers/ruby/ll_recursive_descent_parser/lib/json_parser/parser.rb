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
  U = "u"
  TRUE = "true"
  FALSE = "false"
  NEGATIVE_SIGN = "-"
  DECIMAL = "."
  ESCAPE = "\\"
  EOF = nil

  def parse(input) 
    @input = input
    @current_index = -1
    consume
    json?
  end

  private
  
  def match(token)
    raise InvalidTokenError, 
      "Encountered unexpected token: \"#{@current}\", Expected: \"#{token}\" " \
      "at index #{@current_index}" \
      unless @current == token

    consume
  end

  def consume
    @current_index += 1
    if @current_index > (@input.length - 1)
      @current = EOF
    else
      @current = @input[@current_index]
      consume if white_space?
    end
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
    object_properties unless @current == RIGHT_CURLY_BRACE
    match(RIGHT_CURLY_BRACE)
  end

  def object_properties
    name_value_pairs 
    while @current == COMMA
      match(COMMA)
      name_value_pairs
    end
  end

  def name_value_pairs
    string
    match(COLON)
    value
  end

  def array
    match(LEFT_SQUARE_BRACE)
    value 
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
      match(U)
      4.times do 
        raise InvalidUnicodeEscapeError, 
              "\"#{@current}\" is not a valid hexadecimal digit" \
              unless hex_digit?

        consume 
      end
    elsif escape_character?
      consume
    end
  end

  def true_literal
    TRUE.each_char { |c| match(c) }
  end

  def false_literal
    FALSE.each_char { |c| match(c) }
  end

  def number
    match(NEGATIVE_SIGN) if @current == NEGATIVE_SIGN
    consume while digit?
    match(DECIMAL) if @current == DECIMAL
    consume while digit?
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
    raise InvalidTokenError, "Encountered: EOF, expected: #{expected}" if eof?
    @current.match(regex)
  end
end