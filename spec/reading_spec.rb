require "spec_helper"

describe Reading do
  subject { described_class.new(value: value, timestamp: timestamp) }

  let(:value) { 1.0 }
  let(:timestamp) { Time.parse("2007-04-05T22:00") }

  describe ".new" do
    it "creates a new Reading instance" do
      expect(subject).not_to be_nil
    end

    context "when given value" do
      context "is nil" do
        let(:value) { nil }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is not a Float" do
        let(:value) { 1 }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is zero" do
        let(:value) { 0.0 }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is less than zero" do
        let(:value) { -1.0 }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context "when given timestamp" do
      context "is nil" do
        let(:timestamp) { nil }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

  describe "#value" do
    it "returns the value" do
      expect(subject.value).to eq value
    end
  end

  describe "#timestamp" do
    it "returns the timestamp" do
      expect(subject.timestamp).to eq timestamp
    end
  end
end
