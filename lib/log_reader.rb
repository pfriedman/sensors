class LogReader

  attr_reader :data, :sensors, :reference, :reference_data

  def initialize(data:)
    @data = data.to_s.split("\n")
    @sensors = []
    set_reference
  end

  def read
    sensor = nil
    data.each do |d|
      values = d.split
      if sensor_data?(values)
        sensor = Sensor.new(name: values[1], type: values[0])
        sensors << sensor
      else
        reading = Reading.new(value: Float(values[1]), timestamp: Time.parse(values[0]))
        sensor.readings << reading
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
    @reference = Reference.new(temperature: Float(values[1]), humidity: Float(values[2]))
  end

  def extract_reference_data
    @reference_data = @data.shift
  end

  def sensor_data?(values)
    Sensor::TYPES.include? values[0]
  end

end
