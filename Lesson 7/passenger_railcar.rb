require_relative 'railcar'

class PassengerRailcar < RailCar

  attr_reader :amount_of_places, :booked_places

  def initialize(amount_of_places = 36)
    @type = 'passenger'
    @amount_of_places = amount_of_places
    @booked_places = 0
    validate!
  end

  def take_a_place
    return if vacant_places < 1

    @booked_places += 1
  end

  def vacant_places
    @amount_of_places - @booked_places
  end

  def validate!
    raise 'Amount of places must be greater than 0' if amount_of_places.zero?
  end
end
