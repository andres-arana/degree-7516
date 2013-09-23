require "plzero/scanner/reading_identifier_state"
require "unit/scanner/helpers"

describe PLZero::Scanner::ReadingIdentifierState do
  extend Scanner::Helpers
  setup_transitions_and_tokens

  context "when initialized with a character" do
    setup_subject "A"

    context ".push SPACE" do
      subject_push " "
      it_causes_transition PLZero::Scanner::InitialState, ""
      it_causes_token :identifier, "A"
    end
  end
end
