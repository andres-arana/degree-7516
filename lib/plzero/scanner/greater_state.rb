require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class GreaterState < ScannerState
      def push(char)
        if char == "="
          emit_token id: :greater_or_equal, value: ">="
          transition_to InitialState, ""
        else
          emit_token id: :greater, value: ">"
          transition_to InitialState, char
        end
      end

      def eof
        emit_token id: :greater, value: ">"
        transition_to InitialState, ""
      end
    end
  end
end
