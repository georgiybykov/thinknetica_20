# frozen_string_literal: true

require 'pry'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validate'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railcar'
require_relative 'passenger_railcar'
require_relative 'cargo_railcar'

class RailRoad
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
    create_a_route: 3,
    set_train_route: 4,
    hitch_on_railcar: 5,
    hitch_off_railcar: 6,
    railcar_load: 7,
    send_the_train_to_the_station: 8,
    move_the_train_one_station_forward_or_back: 9,
    show_the_list_of_the_stations: 10,
    show_the_list_of_the_trains_for_the_station: 11,
    show_the_list_of_the_railcars_for_the_train: 12
  }.freeze

  def start
    puts %(
      0. Exit
      1. Create new station
      2. Create new train
      3. Create a route
      4. Set train route
      5. Hitch on the railcar to the train
      6. Hitch off the railcar from the train
      7. Load the railcar with passengers or take a volume for cargo trains
      8. Send the train to the station
      9. Move the train one station forward or back
      10. Show the list of the stations
      11. Show the list of the trains for the station
      12. Show the list of the railcars for the train
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
      when ACTIONS[:create_a_route]
        create_a_route
      when ACTIONS[:set_train_route]
        set_train_route
      when ACTIONS[:hitch_on_railcar]
        hitch_on_railcar
      when ACTIONS[:hitch_off_railcar]
        hitch_off_railcar
      when ACTIONS[:railcar_load]
        railcar_load
      when ACTIONS[:send_the_train_to_the_station]
        send_the_train_to_the_station
      when ACTIONS[:move_the_train_one_station_forward_or_back]
        move_the_train_one_station_forward_or_back
      when ACTIONS[:show_the_list_of_the_stations]
        show_the_list_of_the_stations
      when ACTIONS[:show_the_list_of_the_trains_for_the_station]
        show_the_list_of_the_trains_for_the_station
      when ACTIONS[:show_the_list_of_the_railcars_for_the_train]
        show_the_list_of_the_railcars_for_the_train
      else
        puts 'You have to choose one of the actions above.'
      end
    end
  end

  private

  # методы ниже вызываются только в классе RailRoad

  def create_new_station
    puts 'Create new station'
    puts 'What is the name of the station?'
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station #{name} has been created."
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_new_train
    puts 'Create new train'
    puts 'What is the number of the train?'
    number = gets.chomp
    print 'Type 1 for passenger type of train or 2 for cargo type of train: '
    choice = gets.chomp.to_i
    case choice
    when 1
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} has been created."
    when 2
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} has been created."
    else
      puts 'The train has not been created. You had to type 1 or 2 to make a choice.'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def hitch_on_railcar
    puts 'Hitch on railcar to the train'
    puts 'What is the NUMBER of the train you would like to hitch the railcar on? '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    number = gets.chomp
    train = @trains.find { |train| train.number == number } || raise('Type correct NUMBER of the train')
    puts "You have chosen the train #{train.number}."

    railcar = create_new_railcar_for(train) || raise('An error with creating the railcar')
    train.add_railcar(railcar)
    @railcars << railcar unless railcar.nil?
    puts 'The railcar has been successfully added.'
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_new_railcar_for(train)
    case train.type
    when 'cargo'
      print 'Type railcar overall volume: '
      railcar_volume = gets.chomp.to_i
      CargoRailcar.new(railcar_volume)
    when 'passenger'
      print 'Type railcar amount of seats: '
      amount_of_seats = gets.chomp.to_i
      PassengerRailcar.new(amount_of_seats)
    end
  end

  def hitch_off_railcar
    puts 'Hitch off railcar from the train'
    puts 'Type the NUMBER of the train. The list of available trains: '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    number = gets.chomp
    train = @trains.find { |train| train.number == number } || raise('Type correct NUMBER of the train')
    puts "You have chosen the train #{train.number}."

    train.remove_railcar(train.railcars.last) if train.railcars.count.positive?
    puts 'The railcar had been hitched off the train.'
  rescue StandardError => e
    puts e.message
    retry
  end

  def railcar_load
    puts 'Loading the railcar'

    puts 'Type the NUMBER of the train. The list of available trains: '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    number = gets.chomp
    train = @trains.find { |train| train.number == number } || raise('Type correct NUMBER of the train')
    puts "You have chosen the train #{train.number}. The amount of railcars is: #{train.railcars.count}"

    print 'Type here the NUMBER of the railcar: '
    railcar_number = gets.chomp.to_i - 1
    loading_railcar = train.railcars[railcar_number]

    puts 'Type the volume you would like to load: '
    volume = gets.chomp.to_i if loading_railcar.type == 'cargo'

    loading_railcar.type == 'cargo' ? loading_railcar.take_volume(volume) : loading_railcar.take_a_place
    puts 'Loading has been finished successfully.'
    puts loading_railcar.info
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_a_route
    puts 'Menu to create a route'
    puts 'Type number for: 1 - Create new route; 2 - Add station to the route; 3 - Remove station from the route'
    choice = gets.chomp.to_i
    case choice
    when 1
      create_new_route
    when 2
      add_station_to_the_route
    when 3
      remove_station_from_the_route
    end
  end

  def create_new_route
    puts 'Create new route'
    if @stations.count < 2
      puts 'You have to create 2 stations at least to create new route.'
      return
    end
    puts 'Choose station from the list to set it first station of the route: '
    @stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
    print 'Type the INDEX NUMBER of the station: '
    last_station = first_station = @stations[gets.chomp.to_i]
    loop do
      puts 'Choose station from the list to set it last station of the route: '
      @stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
      print 'Type the INDEX NUMBER of the station: '
      last_station = @stations[gets.chomp.to_i]
      break unless last_station == first_station

      puts 'This station already exists in the route.'
    end
    @routes << Route.new(first_station, last_station)
    puts "The route #{@routes.last.name} has been created."
  end

  def add_station_to_the_route(route = nil)
    puts 'Add station to the route'
    if route.nil?
      puts 'Type the INDEX NUMBER of the route from available: '
      @routes.each_with_index { |route, number| puts "#{number}. #{route.name}" }
      route = @routes[gets.chomp.to_i]
    end

    puts "The route #{route.name}. The list of the stations: "
    @stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
    print 'Type the INDEX NUMBER of the station: '
    new_station = @stations[gets.chomp.to_i]
    puts new_station.name
    return if new_station.nil?

    route.add_station(new_station)
    puts route.stations.map(&:name).join(' - ')
  end

  def remove_station_from_the_route
    puts 'Remove station from the route'
    puts 'The list of the routes: '
    @routes.each_with_index { |route, number| puts "#{number}. #{route.name}" }
    print 'Type the INDEX NUMBER of the route: '
    route = @routes[gets.chomp.to_i]
    return if route.nil?

    route.name
    puts 'The list of the stations of the route: '
    route.stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
    print 'Type the INDEX NUMBER of the station to delete it from the route: '
    station = route.stations[gets.chomp.to_i]
    route.remove_station(station)
    puts "The station #{station.name} was deleted from the route."
  end

  def set_train_route
    puts 'Set train route'
    if @trains.nil?
      puts 'There are no trains available.'
      return
    end
    puts 'Type the INDEX NUMBER of the train to set train route. The list of available trains: '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    train = @trains[gets.chomp.to_i] || raise('You should choose correct INDEX NUMBER of the train')
    puts "You have chosen the train #{train.number}."
    if @routes.nil?
      puts 'There are no available routes.'
      return
    end
    puts 'Type the INDEX NUMBER of the route. The list of available routes: '
    @routes.each_with_index { |route, number| puts "#{number}. #{route.name}" }
    route = @routes[gets.chomp.to_i] || raise('You should choose correct INDEX NUMBER of the route')
    train.take_route(route)
    puts 'The route for the train has been set.'
  rescue StandardError => e
    puts e.message
    retry
  end

  def send_the_train_to_the_station
    puts 'Send the train to the station'
    if @trains.empty?
      puts 'You have to create a train first.'
    elsif @stations.empty?
      puts 'You have to create a station first.'
    else
      puts 'Type the NUMBER of the train you would like to get to the station: '
      @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
      number = gets.chomp
      train = @trains.find { |train| train.number == number }
      if train.nil?
        puts 'The train with this number does not exist.'
      else
        puts 'What is the NAME of the station?'
        @stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
        name = gets.chomp
        station = @stations.find { |station| station.name == name }
        if station.nil?
          puts 'The station with this name does not exist.'
        else
          station.get_train(train)
          puts "The train #{train.number} has been sent to the station #{station.name}."
        end
      end
    end
  end

  def move_the_train_one_station_forward_or_back
    puts 'Move the train one station forward or back on the route'
    puts 'Choose the INDEX NUMBER of the train: '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    train = @trains[gets.chomp.to_i] || raise('Type correct INDEX NUMBER of the train')
    return if train.nil?

    puts "You have chosen the train #{train.number}."

    if train.route.nil?
      puts "The route had not been set for the train #{train.number}."
    else
      puts 'Type your choise: 1 - move the train one station forward; 2 - move the train one station back'
      choise = gets.chomp.to_i
      case choise
      when 1
        train.go_one_station_forward
        puts "The train #{train.number} has gone to the next station."
      when 2
        train.go_one_station_back
        puts "The train #{train.number} has gone to the previous station."
      end
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def show_the_list_of_the_stations
    puts 'The list of the stations: '
    @stations.each { |station| puts station.name }
  end

  def show_the_list_of_the_trains_for_the_station
    puts 'The list of the trains for the station'
    if @stations.empty?
      puts 'You have to create a station first.'
    else
      puts 'What is the NAME of the station?'
      @stations.each_with_index { |station, number| puts "#{number}. #{station.name}" }
      name = gets.chomp
      station = @stations.find { |station| station.name == name }
      puts "The list of the trains for the station #{station.name}: "
      station.each_train { |train| puts train.number }
    end
  end

  def show_the_list_of_the_railcars_for_the_train
    puts 'The list of the railcars for the train'
    puts 'Type the NUMBER of the train. The list of available trains: '
    @trains.each_with_index { |train, number| puts "#{number}. #{train.number}" }
    number = gets.chomp
    train = @trains.find { |train| train.number == number } || raise('Type correct NUMBER of the train')
    puts "You have chosen the train #{train.number}."
    puts "The train #{train.number} has railcars: "
    train.each_railcar { |railcar| puts railcar.info }
  rescue StandardError => e
    puts e.message
    retry
  end
end

RailRoad.new.start
