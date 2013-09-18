require "plzero/scanner/initial_state"
require "unit/scanner/state_spec_helpers"

describe PLZero::Scanner::InitialState do
  subject { described_class.new "" }

  let(:transitions) { [] }
  let(:tokens) { [] }

  before :each do
    subject.on_transition do |new_state, initial_value|
      transitions << { state: new_state, value: initial_value }
    end
    subject.on_token do |token|
      tokens << token
    end
  end

  context ".push" do
    context "when receiving a ' ' character" do
      before(:each) { subject.push " " }
      it_behaves_like "noop"
    end

    context "when receiving a '\t' character" do
      before(:each) { subject.push "\t" }
      it_behaves_like "noop"
    end

    context "when receving an alphabetic character" do
      before(:each) { subject.push "C" }

      it "transitions into reading identifier" do
        expect(transitions).to have(1).items

        transition = transitions.first
        expect(transition[:state]).to be(PLZero::Scanner::ReadingIdentifierState)
        expect(transition[:value]).to eq("C")
      end

      it "does not cause any tokens" do
        expect(tokens).to be_empty
      end
    end
  end

  context ".eof" do
    it "does not cause any tokens" do
      expect(tokens).to be_empty
    end
  end
end
