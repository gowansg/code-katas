module Parser
  extend self
  
  LEFT_CURLY_BRACE = "{"
  RIGHT_CURLY_BRACE = "}"
  LEFT_SQUARE_BRACE = "["
  RIGHT_SQUARE_BRACE = "]"
  COLON = ":"
  QUOTE = "\""
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
    name_value_pairs if match(COMMA)
  end

  def name_value_pairs
    string
    match(COLON)
    value
  end

  def array
    match(LEFT_SQUARE_BRACE)
    value 
    value while match(COMMA)
    match(RIGHT_SQUARE_BRACE)
  end

  def value
    object if @current == LEFT_CURLY_BRACE
    array if @current == LEFT_SQUARE_BRACE
    string if @current == QUOTE
  end

  def string
    match(QUOTE)
    match(string) while valid_character?
    match(QUOTE)
  end

  def match(token)
    raise InvalidTokenError, 
      "Encountered unexpected token: \"#{@current}\", Expected: \"#{token}\"" \
      unless @current == token
    
    consume
  end

  def consume
    @current_index += 1
    if @current_index == (@input.length - 1)
      @current = EOF
    else
      @current = @input[@current_index]
      consume if white_space?
    end
  end

  def white_space?
    @current.match(/\s/)
  end

  def valid_character?
    @current.match(/[^\\"]/)
  end  
end