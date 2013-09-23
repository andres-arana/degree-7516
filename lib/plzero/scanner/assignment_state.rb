require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class AssignmentState < ScannerState
      def push(char)
        if char == ":" and buffer.empty?
          append_to_buffer char
        elsif char == "=" and buffer == ":"
          emit_token id: :assign, value: ":="
          transition_to InitialState, ""
        else
          raise "Invalid symbol #{char}"
        end
      end
    end
  end
end
