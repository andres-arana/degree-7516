shared_examples_for "noop" do
  it "does not cause any transitions" do
    expect(transitions).to be_empty
  end

  it "does not cause any tokens" do
    expect(tokens).to be_empty
  end
end

def setup_subject_state(subject, state)
  state.split("").each do |character|
    subject.push character
  end
end
