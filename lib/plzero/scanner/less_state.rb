require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class LessState < ScannerState
      def push(char)
        if char == "<" and buffer.empty?
          append_to_buffer char
        elsif buffer == "<"
          if char == ">"
            emit_token id: :different, value: "<>"
            transition_to InitialState, ""
          elsif char == "="
            emit_token id: :less_or_equal, value: "<="
            transition_to InitialState, ""
          else
            emit_token id: :less, value: "<"
            transition_to InitialState, char
          end
        end
      end
    end
  end
end
