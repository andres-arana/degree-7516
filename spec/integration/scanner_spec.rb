require "plzero/scanner/scanner"

# Possible tokens:
#   .
#   CONST
#   identifier
#   =
#   number
#   ,
#   ;
#   VAR
#   PROCEDURE
#   :=
#   CALL
#   BEGIN
#   END
#   IF
#   THEN
#   DO
#   WHILE
#   ODD
#   =
#   <=
#   <
#   <>
#   >
#   >=
#   +
#   -
#   *
#   /
#   (
#   )


describe PLZero::Scanner::Scanner do
  let(:output) { [] }

  before :each do
    subject.on_token do |token|
      output.push token
    end
  end

  context "when scanning 'CONST CONST  CONST'" do
    before :each do
      subject.push_line "CONST CONST  CONST"
      subject.eof
    end

    it "emits the appropriate tokens" do
      expect(output).to have(3).items

      item = output[0]
      expect(item[:id]).to eq(:const)
      expect(item[:value]).to eq("CONST")
      expect(item[:line]).to eq("CONST CONST  CONST")

      item = output[1]
      expect(item[:id]).to eq(:const)
      expect(item[:value]).to eq("CONST")
      expect(item[:line]).to eq("CONST CONST  CONST")

      item = output[2]
      expect(item[:id]).to eq(:const)
      expect(item[:value]).to eq("CONST")
      expect(item[:line]).to eq("CONST CONST  CONST")
    end
  end

  context "when scanning 'CONST identifier\nconst ident'" do
    before :each do
      subject.push_line "CONST identifier"
      subject.push_line "const ident"
      subject.eof
    end

    it "emits the appropriate tokens" do
      expect(output).to have(4).items

      item = output[0]
      expect(item[:id]).to eq(:const)
      expect(item[:value]).to eq("CONST")
      expect(item[:line]).to eq("CONST identifier")

      item = output[1]
      expect(item[:id]).to eq(:identifier)
      expect(item[:value]).to eq("identifier")
      expect(item[:line]).to eq("CONST identifier")

      item = output[2]
      expect(item[:id]).to eq(:const)
      expect(item[:value]).to eq("const")
      expect(item[:line]).to eq("const ident")

      item = output[3]
      expect(item[:id]).to eq(:identifier)
      expect(item[:value]).to eq("ident")
      expect(item[:line]).to eq("const ident")
    end
  end
end
