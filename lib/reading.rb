require "time"

class Reading

  attr_reader :value, :timestamp

  # @param [Float] value
  # @param [Time] timestamp
  def initialize(value:, timestamp:)
    @value = value
    @timestamp = timestamp
    raise ArgumentError unless given_valid_arguments?
  end

  private

  def given_valid_arguments?
    return false unless value.is_a? Float
    return false if value <= 0.0
    return false if timestamp.nil?
    true
  end
end