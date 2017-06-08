RSpec.describe ToyRobot::Robot do
  let(:interface) { double(:interface) }
  let(:surface) { ToyRobot::Surface.new(10, 10) }

  subject { described_class.new(interface, surface) }

  shared_examples "coordinates are not changed" do
    it do
      expect { call_method }.to_not change { subject.x }
      expect { call_method }.to_not change { subject.y }
      expect { call_method }.to_not change { subject.facing }
    end
  end

  shared_examples "message are not printed" do
    it do
      expect { call_method }.to_not output(" , , ").to_stdout
    end
  end

  describe "#place" do
    let(:call_method) { subject.place(x, y, facing) }

    context "placement is allowed" do
      let(:x) { 10 }
      let(:y) { 100 }
      let(:facing) { "WEST" }

      before do
        expect(surface).to receive(:placement_is_allowed?)
          .with(x, y)
          .and_return(true)
      end

      it "set x coordinate" do
        expect { call_method }.to change { subject.x }.from(nil).to(x)
      end

      it "set y coordinate" do
        expect { call_method }.to change { subject.y }.from(nil).to(y)
      end

      it "set facing" do
        expect { call_method }.to change { subject.facing }.from(nil).to(facing)
      end
    end

    context "placement is not allowed" do
      let(:x) { 1_000 }
      let(:y) { -100 }
      let(:facing) { nil }

      before do
        expect(surface).to receive(:placement_is_allowed?)
          .with(x, y)
          .and_return(false)
      end

      it "print message about problem" do
        expect { call_method }.to output("Placement is not allowed!\n").to_stdout
      end

      it_behaves_like "coordinates are not changed"
    end
  end

  describe "#move" do
    let(:call_method) { subject.move }

    context "move is allowed" do
      let(:x) { 3 }
      let(:y) { 3 }
      let(:facing) { "WEST" }

      before do
        subject.place(x, y, facing)
      end

      it "set x coordinate" do
        expect { call_method }.to change { subject.x }.from(x).to(2)
      end

      it "does not change y coordinate" do
        expect { call_method }.to_not change { subject.y }.from(y)
      end

      it "does not change facing" do
        expect { call_method }.to_not change { subject.facing }.from(facing)
      end
    end

    context "move is not allowed" do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:facing) { "WEST" }

      before do
        subject.place(x, y, facing)
      end

      it_behaves_like "coordinates are not changed"
      it_behaves_like "message are not printed"
    end

    context "robot is not placed on surface" do
      it_behaves_like "coordinates are not changed"
      it_behaves_like "message are not printed"
    end
  end

  describe "#left" do
    let(:call_method) { subject.left }

    context "robot is placed on surface" do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:facing) { "WEST" }

      before do
        subject.place(x, y, facing)
      end

      it "set facing" do
        expect { call_method }.to change { subject.facing }.from(facing).to("SOUTH")
      end

      it "does not change x" do
        expect { call_method }.to_not change { subject.x }
      end

      it "does not change y" do
        expect { call_method }.to_not change { subject.y }
      end
    end

    context "robot is not placed on surface" do
      it_behaves_like "coordinates are not changed"
      it_behaves_like "message are not printed"
    end
  end

  describe "#right" do
    let(:call_method) { subject.right }

    context "robot is placed on surface" do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:facing) { "WEST" }

      before do
        subject.place(x, y, facing)
      end

      it "set facing" do
        expect { call_method }.to change { subject.facing }.from(facing).to("NORTH")
      end

      it "does not change x" do
        expect { call_method }.to_not change { subject.x }
      end

      it "does not change y" do
        expect { call_method }.to_not change { subject.y }
      end
    end

    context "robot is not placed on surface" do
      it_behaves_like "coordinates are not changed"
      it_behaves_like "message are not printed"
    end
  end

  describe "#report" do
    let(:call_method) { subject.report }

    context "robot is placed on surface" do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:facing) { "WEST" }

      before do
        subject.place(x, y, facing)
      end

      it "print current coordinates and facing" do
        expect { call_method }.to output("0, 0, WEST\n").to_stdout
      end
    end

    context "robot is not placed on surface" do
      it_behaves_like "coordinates are not changed"
      it_behaves_like "message are not printed"
    end
  end
end
