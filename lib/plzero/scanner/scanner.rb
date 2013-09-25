require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class Scanner
      def initialize
        @callbacks = []
        @errors = []
        transition InitialState, ""
      end

      def on_token(&callback)
        @callbacks.push callback
      end

      def on_error(&callback)
        @errors.push callback
      end

      def push(line)
        @current_line = line.chomp
        line.split("").each do |char|
          do_push char
        end
        do_push "\n"
      end

      def eof
        @state.eof
      rescue RuntimeError => e
        @errors.each do |callback|
          callback.call "Line #{@current_line}: #{e}"
        end
      end

      private
      def transition(state, initial_value)
        @state = state.new

        @state.on_transition do |new_state, initial_value|
          transition(new_state, initial_value)
        end

        @state.on_token do |token|
          emit(token)
        end

        unless initial_value.empty?
          initial_value.split("").each do |char|
            @state.push char
          end
        end
      end

      def emit(token)
        @callbacks.each do |callback|
          callback.call token.merge(line: @current_line)
        end
      end

      def do_push(char)
        @state.push char
      rescue RuntimeError => e
        @errors.each do |callback|
          callback.call "Line #{@current_line}: #{e}"
        end
      end
    end
  end
end
