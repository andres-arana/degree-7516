require "plzero/scanner/scanner"

module PLZero
  module Scanner
    class TokenProvider
      def initialize
        @scanner = PLZero::Scanner::Scanner.new
        @buffer = []
        @input_pending = true

        @scanner.on_token do |token|
          @buffer.push token
        end
      end

      def fetch
        while @buffer.empty? and @input_pending
          populate_buffer
        end
        @buffer.shift
      end

      def on_error(&callback)
        @scanner.on_error do |error|
          callback.call error
        end
      end

      private
      def populate_buffer
        line = ARGF.readline
        @scanner.push line
      rescue EOFError => e
        @input_pending = false
        @scanner.eof
      end
    end
  end
end
