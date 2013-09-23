require "plzero/scanner/scanner_state"
require "plzero/scanner/identifier_state"
require "plzero/scanner/number_state"
require "plzero/scanner/assignment_state"
require "plzero/scanner/less_state"
require "plzero/scanner/greater_state"
require "plzero/scanner/string_state"

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
        "(" => :open_paren,
        ")" => :close_paren
      }

      def push(char)
        if char =~ /[a-zA-Z]/ # Alphabetic
          transition_to IdentifierState, char
        elsif char =~ /\d/ # Digits
          transition_to NumberState, char
        elsif char == "'" # Strings
          transition_to StringState, ""
        elsif char =~ /\s/ # Whitespace
          # Ignore whitespaces
        elsif char == ":"
          transition_to AssignmentState, ""
        elsif char == "<"
          transition_to LessState, ""
        elsif char == ">"
          transition_to GreaterState, ""
        elsif SYMBOLS.has_key? char
          emit_token id: SYMBOLS[char], value: char
        else
          emit_token id: :null, value: char
        end
      end

      def eof

      end
    end
  end
end
