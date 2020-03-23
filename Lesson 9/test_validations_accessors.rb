# frozen_string_literal: true

# README ====>>>> TO RUN THIS FILE YOU HAVE TO UNCOMMENT 16th LINE IN station.rb

# for strong_attr_accessor in station.rb
class TestClass; end

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railcar'
require_relative 'passenger_railcar'
require_relative 'cargo_railcar'

# Test exceptions
begin
  action ||= 0
  case action
  when 0
    CargoTrain.new('123')
  when 1
    station = Station.new(123)
  when 2
    station = Station.new('Mos')
  end
rescue RuntimeError => e
  action += 1
  puts e.message
  retry
end

# attr_accessor_with_history
route = Route.new('Mo', 'Saint')
route.stations = 'Foo'
route.stations = 'Bar'
route.stations = 'Lod'
puts("Accessor history: #{route.stations_history}")

# strong_attr_accessor
station.test_var = TestClass.new
puts station.test_var
station.test_var = PassengerTrain.new('12453')
