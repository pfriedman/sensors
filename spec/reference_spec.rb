require "spec_helper"

describe Reference do
  subject { described_class.new(thermometer: thermometer, humidity: humidity) }

  let(:thermometer) { 1.0 }
  let(:humidity) { 1.0 }

  describe ".new" do
    it "creates a new Reference instance" do
      expect(subject).not_to be_nil
    end

    context "when given thermometer" do
      context "is nil" do
        let(:thermometer) { nil }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is not a Float" do
        let(:thermometer) { 1 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is zero" do
        let(:thermometer) { 0.0 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is less than zero" do
        let(:thermometer) { -1.0 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context "when given humidity" do
      context "is nil" do
        let(:humidity) { nil }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is not a Float" do
        let(:humidity) { 1 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is zero" do
        let(:humidity) { 0.0 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is less than zero" do
        let(:humidity) { -1.0 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

  describe "#thermometer" do
    it "returns the thermometer" do
      expect(subject.thermometer).to eq thermometer
    end
  end

  describe "#humidity" do
    it "returns the humidity" do
      expect(subject.humidity).to eq humidity
    end
  end
end
