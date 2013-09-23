require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class NumberState < ScannerState

      MAX_NUMBER_SIZE = 10
      MAX_NUMBER = 2147483648

      def initialize
        super
        @buffer_size_panic = false
      end

      def push(char)
        if char =~ /\d/
          if buffer.length > MAX_NUMBER_SIZE - 1
            if not @buffer_size_panic
              @buffer_size_panic = true
              append_to_buffer "..."
              raise "Number '#{buffer}' is too long, should be less than #{MAX_NUMBER_SIZE} digits"
            end
          else
            append_to_buffer char
          end
        else
          emit
        end
      end

      def eof
        emit
      end

      private
      def emit
        if @buffer_size_panic
          emit_token id: :err_number_long, value: buffer
          transition_to InitialState, ""
        elsif buffer.to_i > MAX_NUMBER
          emit_token id: :err_number_big, value: buffer
          transition_to InitialState, ""
          raise "Number '#{buffer}' is too big, should be less than #{MAX_NUMBER}"
        else
          emit_token id: :number, value: buffer
          transition_to InitialState, ""
        end
      end
    end
  end
end
