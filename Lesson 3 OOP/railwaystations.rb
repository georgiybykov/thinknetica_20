class Station

  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type)
    @trains.select { |train| train if train.type == type }
  end
end

class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end
end

class Train

  attr_reader :type, :speed

  def initialize(number_of_train, type, amount_of_railcars)
    @number_of_train = number_of_train
    @type = type
    @amount_of_railcars = amount_of_railcars
    @speed = 0
  end

  def go(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_railcar
    @amount_of_railcars += 1 if !@speed.zero?
  end

  def remove_railcar
    @amount_of_railcars -= 1 if !@speed.zero? && @amount_of_railcars > 0
  end

  def take_route(route)
    @route = route # route = Route.new
    @route.stations.first.get_train(self)
    @station_index = 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    return if @station_index == @route.stations.size - 1
    @route.stations[@station_index + 1]
  end

  def previous_station
    return if @station_index == 0
    @route.stations[@station_index - 1]
  end

  def go_one_station_forward
    return unless next_station
    @route.stations[@station_index].send_train(self)
    @route.stations[@station_index + 1].get_train(self)
  end

  def go_one_station_back
    return unless previous_station
    @route.stations[@station_index].send_train(self)
    @route.stations[@station_index - 1].get_train(self)
  end
end


station_spb = Station.new("Saint-Petersburg")
station_msk = Station.new("Moscow")
station_blg = Station.new("Bologoe")
station_krd = Station.new("Krasnodar")
station_rd = Station.new("Rostov-on-Don")
station_kpv = Station.new("Kopishevo")

route_spb_msk = Route.new(station_spb, station_msk)
route_spb_msk.add_station(station_blg)
route_spb_msk.add_station(station_kpv)
route_spb_msk.add_station(station_rd)
route_spb_msk.stations
route_spb_msk.remove_station(station_rd)
route_spb_msk.stations

train1 = Train.new(1, "Passenger car", 15)
train2 = Train.new(2, "Freight car", 25)
train3 = Train.new(3, "Passenger car", 17)
train4 = Train.new(4, "Freight car", 32)

train1.take_route(route_spb_msk)
train1.go_one_station_forward
train1.current_station
train1.next_station
train1.previous_station

station_spb.send_train(train1)
station_blg.get_train(train1)

puts station_blg.trains

train1.go_one_station_forward
train1.go_one_station_back

station_rd.get_train(train2)
station_kpv.send_train(train3)
station_krd.get_train(train4)

puts station_blg.show_trains_by_type("Passenger car")
puts station_spb.show_trains_by_type("Freight car")

train1.add_railcar
train2.remove_railcar
train1.go(70)
puts train1.speed
train1.add_railcar
train1.stop
puts train1.speed
