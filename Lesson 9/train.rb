# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
require_relative 'railcar'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[[a-z]\d]{3}+-*+[[a-z]\d]{2}$/i.freeze

  attr_accessor :number, :type
  attr_reader :railcars, :speed, :route

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @railcars = []
    @speed = 0
    @@trains[self.number] = self
    validate!
    register_instance
  end

  def go(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_railcar(railcar)
    return unless railcar.type == @type && @speed.zero?

    @railcars << railcar
  end

  def remove_railcar(railcar)
    @railcars.delete(railcar) if @speed.zero? && railcar.type == @type
  end

  def take_route(route)
    @route = route # route = Route.new
    @route.stations.first.get_train(self)
    @station_index = 0
  end

  def go_one_station_forward
    return if next_station.nil?

    # @route.stations[@station_index].send_train(self)
    # @route.stations[@station_index + 1].get_train(self)
    current_station.send_train(self)
    next_station.get_train(self)
    @station_index += 1
  end

  def go_one_station_back
    return if previous_station.nil?

    # @route.stations[@station_index].send_train(self)
    # @route.stations[@station_index - 1].get_train(self)
    current_station.send_train(self)
    previous_station.get_train(self)
    @station_index -= 1
  end

  def current_station
    return if @route.nil?

    @route.stations[@station_index]
  end

  def each_railcar
    raise "There are no railcars for the train #{number}." if @railcars.empty?

    @railcars.each { |railcar| yield(railcar) } if block_given?
  end

  protected

  # методы ниже не вызываются из интерфейса, но находятся в родительском классе и вызываются в дочерних классах

  def next_station
    return if @station_index == @route.stations.size - 1

    @route.stations[@station_index + 1]
  end

  def previous_station
    return if @station_index.zero?

    @route.stations[@station_index - 1]
  end
end
