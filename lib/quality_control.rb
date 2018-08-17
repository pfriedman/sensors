class QualityControl

  attr_reader :log_reader, :sensors

  def initialize(data:)
    @log_reader = LogReader.new(data: data)
    @log_reader.read
    @sensors = @log_reader.sensors
  end

  def output
    sensors.each_with_object({}) do |sensor, hash|
      hash[sensor.name] = sensor.quality
    end
  end
end