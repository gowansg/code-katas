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
  TRUE = "true"
  FALSE = "false"
  NEGATIVE_SIGN = "-"
  DECIMAL = "."
  EOF = nil

  def parse(input)
    if File.exists?(input)
      File.open(input, "r") do |file|
        @input = file
      end
    else 
      @input = input
    end
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
    consume while valid_character?
    match(QUOTE)
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
    @current.match(/\s/)
  end

  def valid_character?
    @current.match(/[^\\"]/)
  end

  def digit?
    @current.match(/\d/)
  end
end