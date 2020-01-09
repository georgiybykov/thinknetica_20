class Station

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  private

  attr_reader :trains

  # этот метод используется только внутри класса
  def show_trains_by_type(type)
    @trains.select { |train| train if train.type == type }
  end
end
