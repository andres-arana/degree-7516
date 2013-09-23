require "plzero/scanner/scanner_state"
require "plzero/scanner/identifier_state"
require "plzero/scanner/number_state"
require "plzero/scanner/assignment_state"

module PLZero
  module Scanner
    class InitialState < ScannerState
      SYMBOLS = {
        "." => :point,
        "=" => :equals,
        "," => :comma,
        ";" => :semicolon,
        "+" => :plus,
        "-" => :minus,
        "*" => :times,
        "/" => :divided_by,
        "(" => :open_p,
        ")" => :close_p
      }

      def push(char)
        if char =~ /[a-zA-Z]/ # Alphabetic
          transition_to IdentifierState, char
        elsif char =~ /\d/ # Digits
          transition_to NumberState, char
        elsif char =~ /\s/ # Whitespace
          # Ignore whitespaces
        elsif char == ":"
          transition_to AssignmentState, char
        elsif char == "<"
          transition_to LessState, char
        elsif char == ">"
          transition_to GreaterState, char
        elsif SYMBOLS.has_key? char
          emit_token id: SYMBOLS[char], value: char
        else
          raise "Invalid symbol #{char}"
        end
      end
    end
  end
end
