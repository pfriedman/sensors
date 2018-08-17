class Reference
  attr_reader :thermometer, :humidity

  # @param [Float] thermometer the target value for Sensors of type thermometer
  # @param [Float] humidity the target value for Sensors of type humidity
  # @raise [ArgumentError] if either given value is not a Float or is less than zero
  def initialize(thermometer:, humidity:)
    @thermometer = thermometer
    @humidity = humidity
    raise ArgumentError unless given_valid_arguments?
  end

  private

  def given_valid_arguments?
    [thermometer, humidity].each do |value|
      return false unless value.is_a? Float
      return false if value <= 0.0
    end
    true
  end
end


