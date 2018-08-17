class Sensor

  HUMIDITY = "humidity".freeze
  THERMOMETER = "thermometer".freeze
  TYPES = [HUMIDITY, THERMOMETER].freeze

  attr_reader :name, :target
  attr_accessor :readings

  # @param[String] name - the name of the sensor
  # @param[Float] target - the number used to determine quality
  def initialize(name:, target:)
    @name = name
    @target = target
    @readings = []
    raise ArgumentError if name.nil? || name.length <= 0
  end

  # @return [NilClass] To be implemented by subclasses
  def quality
    nil
  end

  # @return[Float] - the mean of the Readings.value
  def mean
    @mean ||= reading_values.sum / reading_values.length.to_f
  end

  # @return[Float] - the standard deviation of the Readings.value
  def standard_deviation
    @standard_deviation ||= Math.sqrt(sample_variance)
  end

  private

  # @return [NilClass] To be implemented by subclasses
  def within_range?
    nil
  end

  def reading_values
    @reading_values ||= readings.each_with_object([]) { |r, arr| arr << r.value }
  end

  def sample_variance
    sum = reading_values.inject(0) { |acc, i| acc + (i - mean)**2 }
    sum / standard_deviation_denominator
  end

  # See below for the reason for the minus one
  # http://www.macroption.com/population-sample-variance-standard-deviation/
  def standard_deviation_denominator
    (reading_values.length - 1).to_f
  end

end