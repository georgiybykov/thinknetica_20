require_relative 'railcar'

class CargoCar < RailCar

  def initialize
    @type = 'cargo'
  end
end
