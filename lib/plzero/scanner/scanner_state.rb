module PLZero
  module Scanner
    class ScannerState
      def initialize
        @buffer = ""
      end

      def on_transition(&transition)
        @on_transition = transition
      end

      def on_token(&token)
        @on_token = token
      end

      protected
      def transition_to(new_state, initial_value = "")
        @on_transition.call new_state, initial_value
      end

      def emit_token(token)
        @on_token.call token
      end

      def buffer
        @buffer
      end

      def append_to_buffer(char)
        @buffer << char
      end
    end
  end
end
