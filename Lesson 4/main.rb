require 'pry'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railcar'
require_relative 'passenger_railcar'
require_relative 'cargo_railcar'

class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @railcars = []
  end

  ACTIONS = {
    exit: 0,
    create_new_station: 1,
    create_new_train: 2,
    hook_the_railcar_to_the_train: 3,
    unhook_the_railcar_from_the_train: 4,
    send_the_train_to_the_station: 5,
    show_the_list_of_the_stations: 6,
    show_the_list_of_the_trains_for_the_station: 7
  }

  def start
    puts %Q(
      0. Exit
      1. Create new station
      2. Create new train
      3. Hook the railcar to the train
      4. Unhook the railcar from the train
      5. Send the train to the station
      6. Show the list of the stations
      7. Show the list of the trains for the station
    )

    loop do
      print 'Type here the action number: '
      action = gets.chomp.to_i

      case action
      when ACTIONS[:exit]
        puts 'See you later! Good bye.'
        break
      when ACTIONS[:create_new_station]
        create_new_station
      when ACTIONS[:create_new_train]
        create_new_train
      when ACTIONS[:hook_the_railcar_to_the_train]
        hook_the_railcar_to_the_train
      when ACTIONS[:unhook_the_railcar_from_the_train]
        unhook_the_railcar_from_the_train
      when ACTIONS[:send_the_train_to_the_station]
        send_the_train_to_the_station
      when ACTIONS[:show_the_list_of_the_stations]
        show_the_list_of_the_stations
      when ACTIONS[:show_the_list_of_the_trains_for_the_station]
        show_the_list_of_the_trains_for_the_station
      else
        puts 'You have to choose one of the actions above.'
      end
    end
  end

  def create_new_station
    puts 'What is the name of the station?'
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station #{name} has been created."
  end

  def create_new_train
    puts 'What is the number of the train?'
    number_of_train = gets.chomp
    print 'Type 1 for passenger railcar or 2 for cargo railcar: '
    choice = gets.chomp.to_i
    case choice
    when 1
      @trains << PassengerTrain.new(number_of_train)
      puts "Passenger train #{number_of_train} has been created."
    when 2
      @trains << CargoTrain.new(number_of_train)
      puts "Cargo train #{number_of_train} has been created."
    else
      puts 'The train has not been created. You had to type 1 or 2 to make a choice.'
    end
  end

  def hook_the_railcar_to_the_train
    if @trains.empty?
      puts 'You have to create a train first.'
    else
      puts 'What is the number of the train you would like to hook the railcar?'
      number = gets.chomp
      train = @trains.find { |train| train.number_of_train == number }
      if train.nil?
        puts 'The train with this number does not exist.'
      else
        train.add_railcar(RailCar.new(train.type))
      end
    end
  end

  def unhook_the_railcar_from_the_train
    if @trains.empty?
      puts 'You have to create a train first.'
    else
      puts 'What is the number of the train you would like to unhook the railcar?'
      number = gets.chomp
      train = @trains.find { |train| train.number_of_train == number }
      if train.nil?
        puts 'The train with this number does not exist.'
      else
        train.remove_railcar(train.railcars.last)
      end
    end
  end

  def send_the_train_to_the_station
    if @trains.empty?
      puts 'You have to create a train first.'
    elsif @stations.empty?
      puts 'You have to create a station first.'
    else
      puts 'Type the number of train you would like to get to the station: '
      number = gets.chomp
      train = @trains.find { |train| train.number_of_train == number }
      if train.nil?
        puts 'The train with this number does not exist.'
      else
        puts 'What is the name of the station?'
        name = gets.chomp
        station = @stations.find { |station| station.name == name }
        if station.nil?
          puts 'The station with this name does not exist.'
        else
          station.get_train(train)
        end
      end
    end
  end

  def show_the_list_of_the_stations
    puts 'The list of the stations: '
    @stations.each { |station| puts station.name }
  end

  def show_the_list_of_the_trains_for_the_station
    if @stations.empty?
      puts 'You have to create a station first.'
    else
      puts 'What is the name of the station?'
      name = gets.chomp
      station = @stations.find { |station| station.name == name }
      if station.nil?
        puts 'The station with this name does not exist.'
      else
        station.show_trains_by_type
      end
    end
  end
end

Main.new.start

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
route_spb_msk.stations
route_spb_msk.remove_station(station_rd)
route_spb_msk.stations

train1 = Train.new(1, "Passenger car")
train2 = Train.new(2, "Freight car")
train3 = Train.new(3, "Passenger car")
train4 = Train.new(4, "Freight car")

train1.take_route(route_spb_msk)
train1.go_one_station_forward
train1.current_station
train1.next_station
train1.previous_station

station_spb.send_train(train1)
station_blg.get_train(train1)

train1.go_one_station_forward
train1.go_one_station_back

station_rd.get_train(train2)
station_kpv.send_train(train3)
station_krd.get_train(train4)
=end
