require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class StringState < ScannerState
      def push(char)
        if char == "'"
          emit_token id: :string, value: buffer
          transition_to InitialState, ""
        elsif char == "\n"
          emit_token id: :null, value: buffer
          transition_to InitialState, ""
        else
          append_to_buffer char
        end
      end

      def eof
        emit_token id: :null, value: buffer
        transition_to InitialState, ""
      end
    end
  end
end
