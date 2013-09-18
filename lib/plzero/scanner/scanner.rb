require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class Scanner
      def initialize
        @callbacks = []
        transition InitialState, ""
      end

      def on_token(&callback)
        @callbacks.push callback
      end

      def push_line(line)
        @current_line = line
        line.split("").each do |char|
          @state.push char
        end
        @state.push "\n"
      end

      def eof
        @state.eof
      end

      private
      def transition(state, initial_value)
        @state = state.new initial_value

        @state.on_transition do |new_state, initial_value|
          transition(new_state, initial_value)
        end

        @state.on_token do |token|
          emit(token)
        end
      end

      def emit(token)
        @callbacks.each do |callback|
          callback.call token.merge(line: @current_line)
        end
      end
    end
  end
end
