class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  private

  # метод используется только внутри класса
  def add_station(station)
    self.stations.insert(-2, station) unless @stations.include?(station)
  end

  # метод используется только внутри класса
  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end
end
