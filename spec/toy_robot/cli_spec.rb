RSpec.describe ToyRobot::CLI do
  describe "#start" do
    context "in interactive mode" do
      it "execute interactive interface" do
        expect(ToyRobot::Interfaces::InteractiveInterface).to receive(:new)
        subject.start
      end
    end

    context "in file mode" do
      let(:file_path) { '/foo/bar' }
      before do
        subject.options = { file: file_path }
      end

      it "execute file interface" do
        expect(ToyRobot::Interfaces::FileInterface).to receive(:new).with(file_path)
        subject.start
      end
    end
  end
end

