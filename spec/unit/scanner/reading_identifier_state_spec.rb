require "plzero/scanner/reading_identifier_state"

describe PLZero::Scanner::ReadingIdentifierState do
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

  context "when having scanned a valid identifier" do
    before(:each) { setup_subject_state subject, "identifier" }

    context ".push" do
      context "when receiving a non-space character" do
        before(:each) { subject.push "e" }
        it_behaves_like "noop"
      end

      context "when receiving a ' ' character" do
        before(:each) { subject.push " " }

        it "transitions into the initial state" do
          expect(transitions).to have(1).items

          item = transitions.first
          expect(item[:state]).to be(PLZero::Scanner::InitialState)
          expect(item[:value]).to eq("")
        end

        it "causes an identifier token" do
          expect(tokens).to have(1).items

          item = tokens.first
          expect(item[:id]).to be(:identifier)
          expect(item[:value]).to eq("identifier")
        end
      end
    end

    context ".eof" do
      before(:each) { subject.eof }

      it "causes an identifier token" do
        expect(tokens).to have(1).items

        item = tokens.first
        expect(item[:id]).to be(:identifier)
        expect(item[:value]).to eq("identifier")
      end
    end
  end

  context "when having scanned a const" do
    before(:each) { setup_subject_state subject, "const" }

    context "when receiving a non-space character" do
      before(:each) { subject.push "e" }
      it_behaves_like "noop"
    end

    context "when receiving a ' ' character" do
      before(:each) { subject.push " " }

      it "transitions into the initial state" do
        expect(transitions).to have(1).items

        item = transitions.first
        expect(item[:state]).to be(PLZero::Scanner::InitialState)
        expect(item[:value]).to eq("")
      end

      it "causes const token" do
        expect(tokens).to have(1).items

        item = tokens.first
        expect(item[:id]).to be(:const)
        expect(item[:value]).to eq("const")
      end
    end
  end
end
