# Main class for problem described in notes
class QualityControl

  attr_reader :log_reader, :sensors

  # Data expected is in the log file format as described in notes
  # This data is passed directly to the LogReader
  # @param[String] data
  def initialize(data:)
    @log_reader = LogReader.new(data: data)
    @log_reader.read
    @sensors = @log_reader.sensors
  end

  # Each named sensor with the report on it's quality
  # @return[Hash] The expected output as described in notes
  def output
    sensors.each_with_object({}) do |sensor, hash|
      hash[sensor.name] = sensor.quality
    end
  end
end