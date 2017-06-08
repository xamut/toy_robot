RSpec.describe ToyRobot::CLI do
  describe "#start" do
    let(:length) { 10 }
    let(:width) { 10 }

    before do
      subject.options = { length: length, width: width }
    end

    context "in interactive mode" do
      it "execute interactive interface" do
        expect(ToyRobot::Interfaces::InteractiveInterface).to receive(:new)
          .and_call_original

        expect(ToyRobot::Surface).to receive(:new)
          .with(length, width)
          .and_call_original

        expect(ToyRobot::Robot).to receive(:new)
          .with(
            instance_of(ToyRobot::Interfaces::InteractiveInterface),
            instance_of(ToyRobot::Surface)
          )
          .and_call_original

        subject.start
      end
    end

    context "in file mode" do
      let(:file_path) { '/foo/bar' }
      before do
        subject.options[:file] = file_path
      end

      it "execute file interface" do
        expect(ToyRobot::Interfaces::FileInterface).to receive(:new)
          .with(file_path).and_call_original

        expect(ToyRobot::Surface).to receive(:new)
          .with(length, width)
          .and_call_original

        expect(ToyRobot::Robot).to receive(:new)
          .with(
            instance_of(ToyRobot::Interfaces::FileInterface),
            instance_of(ToyRobot::Surface)
          )
          .and_call_original

        subject.start
      end
    end
  end
end

