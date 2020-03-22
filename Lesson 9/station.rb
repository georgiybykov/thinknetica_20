# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'train'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name, :trains
  attr_accessor_with_history :re

  validate :name, :presence
  validate :name, :type, String

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
    register_instance
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train(&block)
    raise "There are no trains on the station #{name}." if @trains.empty?

    @trains.each { |train| block.call(train) } if block_given?
  end

  protected

  def validate!
    super
    raise 'The name of the station has to be at least 2 symbols' if name.length < 2
    raise 'It is too long name of the station' if name.length > 20

    true
  end
end
