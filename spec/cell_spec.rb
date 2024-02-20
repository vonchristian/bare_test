# frozen_string_literal: true

require_relative "../lib/cell"

RSpec.describe Cell do
  describe "coordinates" do
    let(:cell) { described_class.new(x_axis: 1, y_axis: 1) }

    it { expect(cell.coordinates).to eq([1, 1]) }
  end
end
