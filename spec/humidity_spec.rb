require "spec_helper"

describe Humidity do

  subject { described_class.new(name: name, target: target) }

  let(:name) { "hum-1" }
  let(:target) { 45.0 }
  let(:reading_values) { [] }

  before(:each) do
    allow(subject).to receive(:reading_values).and_return(reading_values)
  end

  describe "#quality" do
    context "keep" do
      let(:reading_values) { [45.1, 45.2, 45.3] }

      it { expect(subject.quality).to eq Humidity::KEEP }
    end

    context "discard" do
      let(:reading_values) { [45.1, 46.2, 47.3] }

      it { expect(subject.quality).to eq Humidity::DISCARD }
    end
  end

end