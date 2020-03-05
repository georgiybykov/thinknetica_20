# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'train'

class RailCar
  include Manufacturer

  attr_reader :type

  def info
    puts '--' * 20
    puts "Railcar type: #{@type}."
    if @type == 'passenger'
      puts "Amount of places #{@amount_of_places}."
    else
      puts "Overall volume #{@overall_volume}."
    end
    print '--' * 20
  end
end
