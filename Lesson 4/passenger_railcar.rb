require_relative 'railcar'

class PassengerCar < Railcar
  def initialize
    @type = 'pessanger'
  end
end
