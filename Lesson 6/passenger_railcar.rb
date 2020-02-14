require_relative 'railcar'

class PassengerCar < RailCar
  def initialize
    @type = 'pessanger'
  end
end
