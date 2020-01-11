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
    @railcars = []
    @routes = []
  end

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
    when 0
      puts 'See you later! Good bye.'
      break
    when 1
      puts 'What is the name of the station?'
      name = gets.chomp
      @stations << Station.new(name)
      puts "Station #{name} has been created."
    when 2
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
    when 3
      if @trains.empty?
        puts 'You have to create a train first.'
      else
        puts 'What is the number of the train you would like to hook the railcar?'
        number = gets.chomp
        train = @trains.find { |train| @train.number_of_train == number }
        if train.nil?
          puts 'The train with this number does not exist.'
        else
          @train.add_railcar(RailCar.new)
        end
      end
    when 4
      if @trains.empty?
        puts 'You have to create a train first.'
      else
        puts 'What is the number of the train you would like to unhook the railcar?'
        number = gets.chomp
        train = @trains.find { |train| @train.number_of_train == number }
        if train.nil?
          puts 'The train with this number does not exist.'
        else
          @train.remove_railcar(@train.railcars.last)
        end
      end
    when 5
      if @trains.empty?
        puts 'You have to create a train first.'
      elsif @stations.empty?
        puts 'You have to create a station first.'
      else
        puts 'Type the number of train you would like to get to the station: '
        number = gets.chomp
        train = @trains.find { |train| @train.number_of_train == number }
        if train.nil?
          puts 'The train with this number does not exist.'
        else
          puts 'What is the name of the station?'
          name = gets.chomp
          station = @stations.find { |station| @station.name == name }
          if station.nil?
            puts 'The station with this name does not exist.'
          else
            @station.get_train(train)
          end
        end
      end
    when 6
      puts 'The list of the stations: '
      @stations.each { |station| puts @station.name }
    when 7
      if @stations.empty?
        puts 'You have to create a station first.'
      else
        puts 'What is the name of the station?'
        name = gets.chomp
        station = @stations.find { |station| @station.name == name }
        if station.nil?
          puts 'The station with this name does not exist.'
        else
          @station.show_trains_by_type(@train.type)
        end
      end
    else
      puts 'You have to choose one of the actions above.'
    end
  end
end

Main.new
