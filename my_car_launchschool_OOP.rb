module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end


class Vechicle

  attr_accessor :color, :speed
  attr_reader :year, :model

  @@number_of_vechicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vechicles += 1
  end

  def self.number_of_vechicles
    puts "This program has created #{@@number_of_vechicles} number of vechicles."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def start_engine
    puts 'Whroom!'
  end

  def stop_engine
    @speed = 0
    puts 'SHHUUUUTT DOOOWN!'
  end

  def go(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def spray_paint(color)
    @color = color
    puts "Your #{@model} vechicle is #{@color} color now."
  end

  def age
    puts "Your #{@model} age is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vechicle

  NUMBER_OF_DOORS = 4

  def self.what_i_am
    puts 'I am a MyCar class!'
  end

  def to_s
    puts "Hello, mate! Glad to see you here! Your car is #{model}, the color is #{color} and the year is #{year}."
  end
end

class MyTruck < Vechicle

  include Towable

  NUMBER_OF_DOORS = 2

  def self.what_i_am
    puts 'I am a MyTruck class!'
  end

  def to_s
    puts "Hello, mate! Glad to see you here! Your truck is #{model}, the color is #{color} and the year is #{year}."
  end
end


car = MyCar.new(2008, 'black', 'BMW')
puts car
car.start_engine
car.go(70)
puts car.speed
puts car.year
puts car.color
puts car.model
car.stop
puts car.speed
car.stop_engine
car.spray_paint('white')
puts car.color
MyCar.what_i_am
MyCar.gas_mileage(10, 524)

truck = MyTruck.new(2010, 'blue', 'Mercedes-Benz')
puts truck
truck.start_engine
truck.go(65)
puts truck.speed
puts truck.year
puts truck.color
puts truck.model
truck.stop
puts truck.speed
truck.stop_engine
truck.spray_paint('green')
puts truck.color
MyTruck.what_i_am
MyTruck.gas_mileage(15, 865)

Vechicle.number_of_vechicles

puts truck.can_tow?(2530)
puts truck.can_tow?(1550)

puts '-----------------'
puts Vechicle.ancestors
puts '-----------------'
puts MyCar.ancestors
puts '-----------------'
puts MyTruck.ancestors
puts '-----------------'

car.age
truck.age
