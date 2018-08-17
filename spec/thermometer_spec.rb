require "spec_helper"

describe Thermometer do

  subject { described_class.new(name: name, target: target) }

  let(:name) { "temp-1" }
  let(:target) { 70.0 }
  let(:reading_values) { [] }

  before(:each) do
    allow(subject).to receive(:reading_values).and_return(reading_values)
  end

  describe "#quality" do
    context "precise" do
      let(:reading_values) { [67.0, 68.0, 69.0, 70.0] }

      it { expect(subject.quality).to eq Thermometer::PRECISE }
    end

    context "precise" do
      let(:reading_values) { [66.0, 67.0, 68.0, 71.0, 72.0, 74.0, 75.0] }

      it { expect(subject.quality).to eq Thermometer::VERY_PRECISE }
    end

    context "ultra precise" do
      let(:reading_values) { [68.0, 69.0, 70.0, 71.0, 72.0] }

      it { expect(subject.quality).to eq Thermometer::ULTRA_PRECISE }
    end
  end

end