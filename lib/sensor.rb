class Sensor

  HUMIDITY = "humidity".freeze
  THERMOMETER = "thermometer".freeze
  TYPES = [ HUMIDITY, THERMOMETER ]

  attr_reader :name, :type
  attr_accessor :readings

  def initialize(name:, type:)
    @name = name
    @type = type
    @readings = Array.new
    raise ArgumentError unless given_valid_arguments?
  end

  private

  def given_valid_arguments?
    return false if name.nil?
    return false unless name.length > 0
    return false unless TYPES.include?(type)
    true
  end

end