require "plzero/scanner/scanner_state"
require "plzero/scanner/reading_identifier_state"

module PLZero
  module Scanner
    class InitialState < ScannerState
      def initialize(initial_value)
        # No processing needs to be done on the initial value as there
        # shouldn't be any.
      end

      def push(char)
        if char =~ /\S/
          transition_to ReadingIdentifierState, char
        end
      end

      def eof
        # If we reach the end of file while on this state, we are done
        # processing all tokens.
      end
    end
  end
end
