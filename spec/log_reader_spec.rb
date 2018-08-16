require "spec_helper"

describe LogReader do
  let(:data) { File.read("./spec/data/log") }

  subject { described_class.new(data: data) }

  describe ".new" do
    it "creates a new LogReader instance" do
      expect(subject).not_to be_nil
    end

    it "instantiates the reference object" do
      expect(subject.reference).to be_an_instance_of(Reference)
    end
  end

  describe "#sensors" do
    it "is instantiated as an empty Array" do
      expect(subject.sensors).to eq []
    end
  end

  describe "#read" do
    before do
      subject.read
    end

    it "creates the Reference with temperature and humidity values" do
      expect(subject.reference).to be_an_instance_of(Reference)
      expect(subject.reference.temperature).to eq 70.0
      expect(subject.reference.humidity).to eq 45.0
    end

    it "creates Sensors with Readings from input data" do
      sensors = subject.sensors
      expect(sensors.count).to eq 4
      [ [0, 13], [1, 5], [2, 3], [3, 5] ].each do |sensor_index, readings_count|
        expect(sensors[sensor_index].readings.count).to eq readings_count
      end
      first_reading = sensors.first.readings.first
      expect(first_reading.value).to eq 72.4
      expect(first_reading.timestamp).to eq Time.parse("2007-04-05T22:00")

      last_reading = sensors.last.readings.last
      expect(last_reading.value).to eq 42.1
      expect(last_reading.timestamp).to eq Time.parse("2007-04-05T22:08")
    end

  end
end