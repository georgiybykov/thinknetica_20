require_relative 'instance_counter'

class Station

  include InstanceCounter
  attr_reader :name, :trains

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type = nil)
    if type
      @trains.each { |train| puts train.number_of_train if train.type == type }
    else
      @trains.each { |train| puts train.number_of_train }
    end
  end
end
