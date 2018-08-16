class Reference
  attr_reader :temperature, :humidity

  def initialize(temperature:, humidity:)
    @temperature = temperature
    @humidity = humidity
    raise ArgumentError unless given_valid_arguments?
  end

  private

  def given_valid_arguments?
    [temperature, humidity].each do |value|
      return false unless value.is_a? Float
      return false if value <= 0.0
    end
    true
  end
end


