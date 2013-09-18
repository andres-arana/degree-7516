require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class ReadingIdentifierState < ScannerState
      def initialize(initial_value)
        @chars = initial_value
      end

      def push(char)
        if char =~ /\s/
          emit
        else
          @chars << char
        end
      end

      def eof
        emit
      end

      private
      def emit
        emit_token id: current_type, value: @chars
        transition_to InitialState, ""
      end

      def current_type
        if @chars =~ /const/i
          :const
        else
          :identifier
        end
      end
    end
  end
end
