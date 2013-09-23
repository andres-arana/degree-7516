require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class AssignmentState < ScannerState
      def push(char)
        if char == "="
          emit_token id: :assign, value: ":="
          transition_to InitialState, ""
        else
          emit_token id: :null, value: ":"
          transition_to InitialState, char
        end
      end

      def eof
        emit_token id: :null, value: ":"
        transition_to InitialState, ""
      end
    end
  end
end
