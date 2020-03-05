require_relative 'instance_counter'
require_relative 'validate'
require_relative 'train'

class Station

  include InstanceCounter
  include Validate

  attr_reader :name, :trains

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

  attr_writer :name

  def validate!
    raise "Station name can't be blank" if name.empty?
    raise 'Name must not be longer than 25 symbols' if name.length > 25
  end
end
