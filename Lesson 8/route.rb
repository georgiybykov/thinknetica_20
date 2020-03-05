require_relative 'station'
require_relative 'instance_counter'

class Route

  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    self.stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def name
    "#{@stations.first.name} - #{@stations.last.name}"
  end
end
