require "spec_helper"

describe Reference do
  subject { described_class.new(temperature: temperature, humidity: humidity) }

  let(:temperature) { 1.0 }
  let(:humidity) { 1.0 }

  describe ".new" do
    it "creates a new Reference instance" do
      expect(subject).not_to be_nil
    end

    context "when given temperature" do
      context "is nil" do
        let(:temperature) { nil }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is not a Float" do
        let(:temperature) { 1 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is zero" do
        let(:temperature) { 0.0 }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is less than zero" do
        let(:temperature) { -1.0 }
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

  describe "#temperature" do
    it "returns the temperature" do
      expect(subject.temperature).to eq temperature
    end
  end

  describe "#humidity" do
    it "returns the humidity" do
      expect(subject.humidity).to eq humidity
    end
  end
end
