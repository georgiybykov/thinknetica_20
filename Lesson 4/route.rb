class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def name
    "#{@stations.first} - #{@stations.last}"
  end
end
