class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
  end

  def show_trains(type = nil)
    if type
      trains.each { |train| train.number_of_train if train.type == type }
    else
      trains.each { |train| train.number_of_train }
    end
  end
end

class Route

  attr_accessor :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)  # переписать метод
    if [@stations.first, @stations.last].include?(station)
      return
    elsif @stations.include?(station)
      @stations.delete(station)
    else
      return
    end
  end
end

class Train

  attr_accessor :number_of_train, :amount_of_railcars, :speed, :route, :station
  attr_reader :type

  def initialize(number_of_train, type, amount_of_railcars, speed = 0)
    @number_of_train = number_of_train
    @type = type
    @amount_of_railcars = amount_of_railcars
    @speed = speed
  end

  def go(speed)
    speed += 1
  end

  def stop
    self.speed = 0
  end

  def add_railcar
    amount_of_railcars += 1 if !speed.zero?
  end

  def remove_railcar
    amount_of_railcars -= 1 if !speed.zero? && amount_of_railcars > 0
  end

  def take_route(route)
    @route = route # route = Route.new
    @current_station = @route.stations.first # @route.stations.first.get_train(self)  ?????
  end

  def go_to(station)
    if route.nil?
      puts 'The train has to have the route.' # return  ???
    elsif @current_station == station
      puts "The train is on the #{@current_station} right now." # return  ???
    elsif @route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "There is no #{station} on the route for the train №#{@number_of_train}." # return  ???
    end
  end

=begin
  def show_stations_list
    if route.nil?
      puts 'The route is not set.'
    else
      station_index = @route.stations.index(@current_station)
      puts "The train №#{@number_of_train} is located at the station #{@current_station.name} right now."
      puts "The previous station is #{@route.stations[station_index - 1].name}." if station_index != 0
      puts "The next station is #{@route.stations[station_index + 1].name}." if station_index != @route.stations.size - 1
    end
  end
=end

  def current_station
    # заменить инстанс-переменную @current_station этим методом
  end

  def next_station

  end

  def previous_station

  end
end




=begin
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
route_spb_msk.show_stations
route_spb_msk.remove_station(station_rd)
route_spb_msk.show_stations

train1 = Train.new(1, "Passenger car", 15)
train2 = Train.new(2, "Freight car", 25)
train3 = Train.new(3, "Passenger car", 17)
train4 = Train.new(4, "Freight car", 32)

train1.take_route(route_spb_msk)
train1.go_to(station_blg)

station_spb.get_train(train1)

station_spb.show_trains

train1.go_to(station_msk)
train1.go_to(station_kpv)

station_rd.get_train(train2)
station_kpv.send_train(train3)
station_krd.get_train(train4)

station_spb.show_trains("Passenger car")
station_spb.show_trains("Freight car")

train1.show_stations_list
train2.show_stations_list

train1.add_remove_railcars(1)
train2.add_remove_railcars(-1)
train1.go
puts train1.speed
train1.add_remove_railcars(1)
train1.stop
puts train1.speed
=end
