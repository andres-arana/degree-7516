require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class IdentifierState < ScannerState
      KEYWORDS = ["const", "var", "procedure", "call", "begin", "end", "if",
                  "then", "while", "do", "odd"]

      def push(char)
        if char =~ /\W/
          # If char is any non-word character, we finished reading the current
          # identifier
          emit_token id: identifier_type, value: buffer
          transition_to InitialState, char
        else
          # Accumulate current identifier
          append_to_buffer char
        end
      end

      private
      def identifier_type
        if KEYWORDS.include? buffer.downcase
          buffer.to_sym
        else
          :identifier
        end
      end
    end
  end
end
