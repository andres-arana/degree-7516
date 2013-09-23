module Scanner
  module Helpers
    def setup_transitions_and_tokens
      let(:transitions) { [] }
      let(:tokens) { [] }
    end

    def setup_subject(initial_value)
      subject do
        described_class.new initial_value
      end
      before :each do
        subject.on_transition do |new_state, initial_value|
          transitions << { state: new_state, value: initial_value }
        end
        subject.on_token do |token|
          tokens << token
        end
      end
    end

    def subject_push(characters)
      before :each do
        characters.split("").each do |char|
          subject.push char
        end
      end
    end

    def subject_eof
      subject.eof
    end

    def it_does_not_cause_transitions
      it "does not cause any transitions" do
        expect(transitions).to be_empty
      end
    end

    def it_causes_transition(state, value)
      it "transitions into #{state}" do
        expect(transitions).to have(1).items

        transition = transitions.first
        expect(transition[:state]).to be(state)
        expect(transition[:value]).to eq(value)
      end
    end

    def it_does_not_cause_tokens
      it "does not cause any tokens" do
        expect(tokens).to be_empty
      end
    end

    def it_causes_token(token, value)
      it "causes #{token} (#{value}) token" do
        expect(tokens).to have(1).items

        t = tokens.first
        expect(t[:id]).to be(token)
        expect(t[:value]).to eq(value)
      end
    end
  end
end

