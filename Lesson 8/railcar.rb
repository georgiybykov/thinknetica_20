# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'train'

class RailCar
  include Manufacturer

  attr_reader :type

  def info
    puts('--' * 30)
    if @type == 'cargo'
      puts "Overall volume: #{@overall_volume}."
      puts "Booked volume: #{@booked_volume}."
      puts "Available volume: #{@overall_volume - @booked_volume}."
    else
      puts "Amount of places: #{@amount_of_places}."
      puts "Booked of places: #{@booked_places}."
      puts "Vacant of places: #{@amount_of_places - @booked_places}."
    end
    puts('--' * 30)
  end
end
