# frozen_string_literal: true

require_relative "../lib/robot"

# rubocop:disable Metrics/BlockLength
RSpec.describe Robot do
  let(:grid) { Grid.new(height: 3, width: 3) }
  let(:robot) { Robot.new(grid: grid) }

  describe "#place!" do
    context "with cell" do
      it do
        cell = grid.find_cell([1, 2])
        robot.place!([1, 2])

        expect(robot.current_cell).to eq cell
      end
    end

    context "with nil cell" do
      it do
        robot.place!(x_axis: 10, y_axis: 20)

        expect(robot.current_cell).to be_nil
      end
    end
  end

  describe "#move!" do
    context "when inside of grid" do
      it "assigns new cell" do
        cell = grid.find_cell([2, 1])
        robot.place!([2, 1])
        robot.move!

        expect(robot.current_cell).to eq cell
      end
    end

    context "when outside of grid" do
      let(:west) { Direction.new(direction: "W") }

      before do
        robot.current_direction = west
        robot.place!([0, 0])
      end

      it "retain existing cell" do
        robot.move!

        expect(robot.current_cell).to eq robot.current_cell
      end
    end
  end

  describe "placed?" do
    context "with current cell" do
      it do
        robot.place!([1, 1])
        expect(robot.placed?).to be_truthy
      end
    end

    context "with no current cell" do
      it { expect(robot.placed?).to be_falsey }
    end
  end

  describe "face_right!" do
    it do
      expect(robot.current_direction).to receive(:right!)

      robot.face_right!
    end
  end

  describe "face_left!" do
    it do
      expect(robot.current_direction).to receive(:left!)

      robot.face_left!
    end
  end

  describe "report" do
    it do
      robot.place!([1, 1])

      expect(robot.report).to eq([1, 1, "E"])
    end
  end
end
# rubocop:enable Metrics/BlockLength
