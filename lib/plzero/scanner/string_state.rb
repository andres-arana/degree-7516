require "plzero/scanner/scanner_state"
require "plzero/scanner/initial_state"

module PLZero
  module Scanner
    class StringState < ScannerState

      MAX_STRING_LENGTH = 1024

      def initialize
        super
        @buffer_size_panic = false
      end

      def push(char)
        if char == "'"
          if @buffer_size_panic
            emit_token id: :err_string_length, value: buffer
            transition_to InitialState, ""
          else
            emit_token id: :string, value: buffer
            transition_to InitialState, ""
          end
        elsif char == "\n"
          emit_token id: :err_string_end, value: buffer
          transition_to InitialState, ""
        else
          if buffer.length > MAX_STRING_LENGTH - 1
            if not @buffer_size_panic
              @buffer_size_panic = true
              append_to_buffer "..."
              raise "String '#{buffer}' is too long, should be less than #{MAX_STRING_LENGTH} characters"
            end
          else
            append_to_buffer char
          end
        end
      end

      def eof
        emit_token id: :err_string_end, value: buffer
        transition_to InitialState, ""
      end
    end
  end
end
