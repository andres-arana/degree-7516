require "plzero/scanner/initial_state"
require "unit/scanner/helpers"

describe PLZero::Scanner::InitialState do
  extend Scanner::Helpers

  setup_subject ""
  setup_transitions_and_tokens

  context ".push SPACE" do
    subject_push " "
    it_does_not_cause_transitions
    it_does_not_cause_tokens
  end

  context ".push TAB" do
    subject_push "\t"
    it_does_not_cause_transitions
    it_does_not_cause_tokens
  end

  context ".push NEWLINE" do
    subject_push "\n"
    it_does_not_cause_transitions
    it_does_not_cause_tokens
  end

  context ".push NON-SPACE" do
    subject_push "A"
    it_causes_transition PLZero::Scanner::ReadingIdentifierState, "A"
    it_does_not_cause_tokens
  end

  context ".eof" do
    it_does_not_cause_transitions
    it_does_not_cause_tokens
  end
end
