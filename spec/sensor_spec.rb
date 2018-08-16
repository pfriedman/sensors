require "spec_helper"

describe Sensor do
  subject { described_class.new(name: name) }

  let(:name) { "temp-1" }

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
end
