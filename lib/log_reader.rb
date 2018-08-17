class LogReader

  attr_reader :data, :sensors, :reference, :reference_data

  # Data expected is in the log file format as described in notes
  # @param[String] data
  def initialize(data:)
    @data = data.to_s.split("\n")
    @sensors = []
    set_reference
  end

  # Reads the log and sets the Reference and Sensors with Readings
  def read
    sensor = nil
    @data.each do |log_item|
      log_values = log_item.split
      if sensor_data?(log_values)
        sensor = create_sensor(log_values)
      else
        create_reading(log_values, sensor)
      end
    end
  end

  private

  # Given a string e.g. "reference 70.0 45.0"
  # extract the temperature and humidity of the test room
  # That is temperature of test room is set
  # at 70.0 degrees and 45.0% humidity
  # in the example string
  def set_reference
    extract_reference_data
    values = reference_data.split
    @reference = Reference.new(thermometer: Float(values[1]), humidity: Float(values[2]))
  end

  def extract_reference_data
    @reference_data = @data.shift
  end

  def sensor_data?(values)
    Sensor::TYPES.include? values[0]
  end

  def create_sensor(log_values)
    type = log_values[0]
    sensor = determine_class(type).new(name: log_values[1], target: target(type))
    sensors << sensor
    sensor
  end

  def determine_class(name)
    Kernel.const_get(name.capitalize)
  end

  def create_reading(log_values, sensor)
    reading = Reading.new(value: Float(log_values[1]), timestamp: Time.parse(log_values[0]))
    sensor.readings << reading
  end

  def target(type)
    reference.send(type)
  end

end
