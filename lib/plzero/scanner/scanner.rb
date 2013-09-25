require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class Scanner
      def initialize
        @current_line_number = 0
        @current_char_number = 0
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
        @current_line_number += 1
        @current_char_number = 0
        line.split("").each do |char|
          @current_char_number += 1
          do_push char
        end
        do_push "\n"
      end

      def eof
        @state.eof
      rescue RuntimeError => e
        report_error e
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
        report_error e
      end

      def report_error(e)
        @errors.each do |callback|
          callback.call({ 
            error: "#{e}",
            line: @current_line,
            line_number: @current_line_number,
            char_number: @current_char_number
          })
        end
      end
    end
  end
end
