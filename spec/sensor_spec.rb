require "spec_helper"

describe Sensor do
  subject { described_class.new(name: name, type: type) }

  let(:name) { "temp-1" }
  let(:type) { "thermometer" }

  describe ".new" do
    it "creates a new Sensor instance" do
      expect(subject).not_to be_nil
    end

    context "when given name" do
      context "is nil" do
        let(:name) { nil }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is blank" do
        let(:name) { "" }
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context "when given type" do
      context "is nil" do
        let(:type) { nil }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "is unknown (not in Sensor::TYPES)" do
        let(:type) { "not_a_known_type" }
        it { expect { subject }.to raise_error(ArgumentError) }
        it { expect(Sensor::TYPES).not_to include(type) }
      end
    end
  end

  describe "#name" do
    it "returns the name" do
      expect(subject.name).to eq name
    end
  end

  describe "#type" do
    it "returns the type" do
      expect(subject.type).to eq type
    end
  end

  describe "#readings" do
    it "returns the Array" do
      expect(subject.readings).to be_an_instance_of(Array)
    end
  end
end
