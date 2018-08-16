require "spec_helper"

describe LogReader do
  subject { described_class.new(data: data) }

  let(:data) { File.read("./spec/data/log") }

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
    before(:each) do
      subject.read
    end

    it "creates the Reference with temperature and humidity values" do
      expect(subject.reference).to be_an_instance_of(Reference)
      expect(subject.reference.thermometer).to eq 70.0
      expect(subject.reference.humidity).to eq 45.0
    end

    it "creates Sensors with Readings from input data" do
      sensors = subject.sensors
      expect(sensors.count).to eq 4
      [ [0, 13], [1, 5], [2, 3], [3, 5] ].each do |sensor_index, readings_count|
        expect(sensors[sensor_index].readings.count).to eq readings_count
      end

      first_sensor = sensors.first
      expect(first_sensor).to be_an_instance_of(Thermometer)
      expect(first_sensor.target).to eq 70.0

      first_reading = first_sensor.readings.first
      expect(first_reading.value).to eq 72.4
      expect(first_reading.timestamp).to eq Time.parse("2007-04-05T22:00")

      last_sensor = sensors.last
      expect(last_sensor).to be_an_instance_of(Humidity)
      expect(last_sensor.target).to eq 45.0

      last_reading = last_sensor.readings.last
      expect(last_reading.value).to eq 42.1
      expect(last_reading.timestamp).to eq Time.parse("2007-04-05T22:08")
    end

  end
end