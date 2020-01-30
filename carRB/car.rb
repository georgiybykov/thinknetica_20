class Car

  attr_reader :current_rpm

  @@instances = 0

  def self.instances
    @@instances
  end

  def self.debug(log)
    puts "!!!DEBUG: #{log} !!!"
  end

  debug 'Start interface'

  def initialize
    @current_rpm = 0
    @@instances += 1
    self.class.debug 'Initialize'
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end

  debug 'End interface'

  protected

  attr_writer :current_rpm

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  # остановить двигатель
end
