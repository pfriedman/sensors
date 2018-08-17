require "spec_helper"

describe QualityControl do
  subject { described_class.new(data: data) }

  let(:data) { File.read("./spec/data/log") }

  describe ".new" do
    it "creates a new LogReader instance" do
      expect(subject).not_to be_nil
    end

    it "instantiates the log reader object" do
      expect(subject.log_reader).to be_an_instance_of(LogReader)
    end

    it "instantiates the sensors object" do
      expect(subject.sensors).to be_an_instance_of(Array)
    end
  end

  describe "#output" do
    let(:expected) do
      {
        "temp-1" => Thermometer::PRECISE,
        "temp-2" => Thermometer::ULTRA_PRECISE,
        "hum-1" => Humidity::KEEP,
        "hum-2" => Humidity::DISCARD
      }
    end

    it "returns the quality result of each sensor" do
      expect(subject.output).to eq expected
    end
  end

end
