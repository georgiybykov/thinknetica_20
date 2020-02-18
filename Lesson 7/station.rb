require_relative 'instance_counter'
require_relative 'validate'

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

  def show_trains_by_type(type = nil)
    if type
      @trains.each { |train| puts train.number if train.type == type }
    else
      @trains.each { |train| puts train.number }
    end
  end

  protected

  attr_writer :name

  def validate!
    raise "Station name can't be blank" if name.empty?
    raise 'Name must not be longer than 25 symbols' if name.length > 25
  end
end
