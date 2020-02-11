class MyCar

  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.what_i_am
    puts 'I am a MyCar class!'
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    puts "Hello, mate! Glad to see you here! Your car is #{model}, the color is #{color} and the year is #{year}."
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
    puts "Your car is #{@color} color now."
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
