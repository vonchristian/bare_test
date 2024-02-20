# frozen_string_literal: true

require_relative "../lib/grid"

# rubocop:disable Metrics/BlockLength
RSpec.describe Grid do
  let(:grid) { described_class.new(height: 6, width: 6) }

  describe "create cells based on height and width" do
    it { expect(grid.cells.size).to eq 36 }
  end

  describe "next_cell" do
    let(:east) { Direction.new(direction: "E") }
    let(:north) { Direction.new(direction: "N") }

    let(:cell) { grid.find_cell([3, 3]) }

    context "when on x-axis" do
      it do
        next_cell = grid.next_cell(direction: east, cell: cell)
        expect(next_cell.coordinates).to eq([4, 3])
      end
    end

    context "when on y-axis" do
      it do
        next_cell = grid.next_cell(direction: north, cell: cell)
        expect(next_cell.coordinates).to eq([3, 4])
      end
    end
  end

  describe "find_cell" do
    it "with valid cell" do
      cell = grid.find_cell([1, 1])
      expect(cell.coordinates).to eq([1, 1])
    end

    it "with invalid cell" do
      cell = grid.find_cell([100, 100])
      expect(cell.nil?).to be_truthy
    end
  end

  describe "outside?" do
    it { expect(grid.outside?([5, 6])).to be_truthy }
    it { expect(grid.outside?([5, 5])).to be_falsey }
  end
end
# rubocop:enable Metrics/BlockLength
