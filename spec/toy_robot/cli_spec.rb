RSpec.describe ToyRobot::CLI do
  describe "#start" do
    let(:length)  { 10 }
    let(:width)   { 10 }

    before do
      subject.options = { length: length, width: width }
      allow_any_instance_of(ToyRobot::Robot).to receive(:start)
    end

    context "in interactive mode" do
      let(:input)   { STDIN }

      it "execute interactive interface" do
        expect(ToyRobot::Interface).to receive(:new)
          .with(input)
          .and_call_original

        expect(ToyRobot::Surface).to receive(:new)
          .with(length, width)
          .and_call_original

        expect(ToyRobot::Robot).to receive(:new)
          .with(
            instance_of(ToyRobot::Interface),
            instance_of(ToyRobot::Surface)
          )
          .and_call_original

        subject.start
      end
    end

    context "in file mode" do
      let(:file_path) { "examples/commands_1.txt" }

      before do
        subject.options[:file] = file_path
      end

      it "execute file interface" do
        expect(ToyRobot::Interface).to receive(:new)
          .with(instance_of(File))
          .and_call_original

        expect(ToyRobot::Surface).to receive(:new)
          .with(length, width)
          .and_call_original

        expect(ToyRobot::Robot).to receive(:new)
          .with(
            instance_of(ToyRobot::Interface),
            instance_of(ToyRobot::Surface)
          )
          .and_call_original

        subject.start
      end
    end

    context "raise error" do
      let(:length) { -100 }

      it "print error message to stdout" do
        error_message = "Wrong length, must be in range 1 to 100\n"
        expect { subject.start }.to output(error_message).to_stdout
      end
    end
  end
end

