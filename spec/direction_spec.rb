# frozen_string_literal: true

require_relative "../lib/direction"

# rubocop:disable Metrics/BlockLength
RSpec.describe Direction do
  let(:east) { described_class.new(direction: "E") }
  let(:west) { described_class.new(direction: "W") }
  let(:north) { described_class.new(direction: "N") }
  let(:south) { described_class.new(direction: "S") }

  it "VALID" do
    expect(described_class::VALID).to match_array(%w[E W N S])
  end

  it "TRANSLATIONS" do
    expect(described_class::TRANSLATIONS).to match_array(
      [
        { direction: "N", right: "E", left: "W" },
        { direction: "E", right: "S", left: "N" },
        { direction: "S", right: "W", left: "E" },
        { direction: "W", right: "N", left: "S" }
      ]
    )
  end

  it "#east?" do
    expect(described_class.new(direction: "E").east?).to be_truthy
  end

  it "#west?" do
    expect(described_class.new(direction: "W").west?).to be_truthy
  end

  it "#north?" do
    expect(described_class.new(direction: "N").north?).to be_truthy
  end

  it "#south?" do
    expect(described_class.new(direction: "S").south?).to be_truthy
  end

  context "x_axis" do
    it { expect(east.x_axis?).to be_truthy }
    it { expect(west.x_axis?).to be_truthy }
    it { expect(north.x_axis?).to be_falsey }
    it { expect(south.x_axis?).to be_falsey }
  end

  describe "right!" do
    context "when east" do
      it do
        east.right!
        expect(east.direction).to eq "S"
      end
    end

    context "when west" do
      it do
        west.right!
        expect(west.direction).to eq "N"
      end
    end

    context "when north" do
      it do
        north.right!
        expect(north.direction).to eq "E"
      end
    end

    context "when south" do
      it do
        south.right!
        expect(south.direction).to eq "W"
      end
    end
  end

  describe "left!" do
    context "when east" do
      it do
        east.left!
        expect(east.direction).to eq "N"
      end
    end

    context "when west" do
      it do
        west.left!
        expect(west.direction).to eq "S"
      end
    end

    context "when north" do
      it do
        north.left!
        expect(north.direction).to eq "W"
      end
    end

    context "when south" do
      it do
        south.left!
        expect(south.direction).to eq "E"
      end
    end
  end

  describe "valid?" do
    it { expect(described_class.new(direction: "E").valid?).to be_truthy }
    it { expect(described_class.new(direction: "X").valid?).to be_falsey }
  end
end
# rubocop:enable Metrics/BlockLength
