class Sensor

  HUMIDITY = "humidity".freeze
  THERMOMETER = "thermometer".freeze
  TYPES = [ HUMIDITY, THERMOMETER ]

  attr_reader :name
  attr_accessor :readings

  def initialize(name:)
    @name = name
    @readings = []
    raise ArgumentError if name.nil? || name.length <= 0
  end

end