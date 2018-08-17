require_relative "sensor"

class Thermometer < Sensor
  ULTRA_PRECISE = "ultra precise".freeze
  VERY_PRECISE  = "very precise".freeze
  PRECISE       = "precise".freeze

  # For a thermometer, it is branded "ultra precise" if
  # the mean of the readings is within 0.5 degrees of the known temperature,
  # and the standard deviation is less than 3.
  # It is branded "very precise" if the mean is within 0.5 degrees of
  # the room, and the standard deviation is under 5.
  # Otherwise, it's sold as "precise".
  #
  # @return [String] "ultra precise", "very precise", or "precise"
  def quality
    return PRECISE unless within_range?
    return ULTRA_PRECISE if standard_deviation < 3.0
    return VERY_PRECISE if standard_deviation < 5.0
    PRECISE
  end

  private

  def within_range?
    (target - mean).abs < 0.5
  end
end