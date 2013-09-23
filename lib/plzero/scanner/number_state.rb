require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class NumberState < ScannerState
      def push(char)
        if char =~ /\d/
          append_to_buffer char
        else
          emit_token id: :number, value: buffer
          transition_to InitialState, char
        end
      end

      def eof
        emit_token id: :number, value: buffer
        transition_to InitialState, ""
      end
    end
  end
end
