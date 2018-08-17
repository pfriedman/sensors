require "spec_helper"

describe Sensor do
  subject { described_class.new(name: name, target: target) }

  let(:name) { "temp-1" }
  let(:target) { 1.0 }

  describe ".new" do
    it "creates a new Sensor instance" do
      expect(subject).not_to be_nil
    end

    context "when name argument is nil" do
      let(:name) { nil }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when name argument is an empty string" do
      let(:name) { "" }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#name" do
    it "returns the name" do
      expect(subject.name).to eq name
    end
  end

  describe "#readings" do
    it "returns the Array" do
      expect(subject.readings).to be_an_instance_of(Array)
    end
  end

  context "statistics from readings" do
    before(:each) do
      [1.32, 2.34, 3.54].each do |value|
        subject.readings << Reading.new(value: value, timestamp: Time.now)
      end
    end

    describe "#mean" do
      it "returns the mean of the readings values" do
        expect(subject.mean).to eq 2.4
      end
    end

    describe "#standard_deviation" do
      it "returns the standard_deviation of the readings values" do
        expect(subject.standard_deviation).to eq 1.111215550647128
      end
    end
  end
end
