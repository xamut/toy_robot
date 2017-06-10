RSpec.describe ToyRobot::Interface do
  subject do
    described_class.new(input)
  end

  describe "#commands" do
    let(:input) { StringIO.new }

    context "read from input" do
      before do
        input.string = <<-COMMANDS
        PLACE 1,1,NORTH
        MOVE
        LEFT
        TEST
        RIGHT
        lEFT
        MOVE
        PLACE 1,1, WEST
        REPORT
        COMMANDS
      end

      it "parse allowed commands" do
        expect { |b| subject.commands(&b) }.to yield_successive_args(
          [:place, "1", "1", "NORTH"],
          [:move],
          [:left],
          [:right],
          [:move],
          [:report]
        )
      end
    end
  end
end
