# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/accessors'
require_relative 'modules/validation'
require_relative 'station'

class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_accessor_with_history :stations
  attr_reader :stations

  validate :stations, :presence
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
