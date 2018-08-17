require_relative "sensor"

class Humidity < Sensor
  KEEP = "keep".freeze
  DISCARD = "discard".freeze

  # For a humidity sensor, it must be discarded unless it is
  # within 1% of the reference value for all readings.
  #
  # @return [String] "keep" or "discard"
  def quality
    within_range? ? KEEP : DISCARD
  end

  private

  def within_range?
    (target - mean).abs < 1
  end
end