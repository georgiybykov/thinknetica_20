# frozen_string_literal: true

require_relative 'station'
require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  validate :stations, :type, Array

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)

    @stations.delete(station)
  end

  def name
    "#{@stations.first.name} - #{@stations.last.name}"
  end
end
