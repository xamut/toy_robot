RSpec.describe ToyRobot::Surface do
  let(:length) { 5 }
  let(:width) { 5 }

  subject { described_class.new(length, width) }

  describe "#initialize" do
    context "takes valid dimensions" do
      it "not raise exception" do
        expect { subject }.to_not raise_exception
      end
    end

    context "takes invalid length" do
      let(:dimensions) {
        [
          [-1, 100],
          [0, 50],
          [1_000, 10]
        ]
      }

      it "raise exception" do
        dimensions.each do |dimension|
          expect { described_class.new(*dimension) }.to raise_exception(ToyRobot::Surface::WrongLength)
        end
      end
    end

    context "takes invalid width" do
      let(:dimensions) {
        [
          [1, -1_000],
          [5, 0],
          [100, 1_000_000]
        ]
      }

      it "raise exception" do
        dimensions.each do |dimension|
          expect { described_class.new(*dimension) }.to raise_exception(ToyRobot::Surface::WrongWidth)
        end
      end
    end
  end

  describe "#step_from_is_allowed?" do
    context "into available place" do
      let(:states) do
        [
          [0, 0, "NORTH"],
          [0, 0, "EAST"],
          [5, 5, "SOUTH"],
          [5, 5, "WEST"],
          [3, 3, "NORTH"],
          [3, 3, "EAST"],
          [3, 3, "SOUTH"],
          [3, 3, "WEST"]
        ]
      end

      it "truthy" do
        states.each do |state|
          expect(subject.step_from_is_allowed?(*state)).to be_truthy
        end
      end
    end

    context "into unavailable place" do
      let(:states) do
        [
          [0, 0, "SOUTH"],
          [0, 0, "WEST"],
          [5, 5, "NORTH"],
          [5, 5, "EAST"],
          [0, 5, "NORTH"],
          [0, 5, "WEST"],
          [5, 0, "SOUTH"],
          [5, 0, "EAST"],
          [0, 3, "WEST"],
          [3, 0, "SOUTH"],
          [3, 5, "NORTH"],
          [5, 3, "EAST"]
        ]
      end

      it "falsey" do
        states.each do |state|
          expect(subject.step_from_is_allowed?(*state)).to be_falsey
        end
      end
    end
  end

  describe "#placement_is_allowed?" do
    context "takes acceptable coordinates" do
      let(:x) { 3 }
      let(:y) { 3 }
      let(:facing) { "WEST" }

      it "truthy" do
        expect(subject.placement_is_allowed?(x, y, facing)).to be_truthy
      end
    end

    context "takes coordinates beyond the limit" do
      let(:x) { 3 }
      let(:y) { 6 }
      let(:facing) { "EAST" }

      it "falsey" do
        expect(subject.placement_is_allowed?(x, y, facing)).to be_falsey
      end
    end

    context "takes negative coordinates" do
      let(:x) { -3 }
      let(:y) { 5 }
      let(:facing) { "SOUTH" }

      it "falsey" do
        expect(subject.placement_is_allowed?(x, y, facing)).to be_falsey
      end
    end

    context "takes not allowed facing" do
      let(:x) { 3 }
      let(:y) { 5 }
      let(:facing) { "NORT" }

      it "falsey" do
        expect(subject.placement_is_allowed?(x, y, facing)).to be_falsey
      end
    end
  end
end
