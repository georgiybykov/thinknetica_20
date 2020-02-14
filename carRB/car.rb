require_relative 'modules'

module FuelTank
  def fill_tank(level)
    self.fuel_tank = level
  end

  def fuel_level
    self.fuel_tank
  end

  protected

  attr_accessor :fuel_tank
end

module Debugger # == Debugger = Module.new do ... end
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def debug(log)
      puts "!!!DEBUG: #{log} !!!"
    end
  end

  module InstanceMethods
    def debug(log)
      self.class.debug(log)
    end

    def print_class
      puts self.class
    end
  end
end

class Car # == Car = Class.new do ... end

  include FuelTank
  include Debugger

  attr_reader :current_rpm
  attr_accessor :number

  NUMBER_FORMAT = /^[a-z]{1}\d{3}[a-z]{2}$/i

  @@instances = 0

  def self.instances
    @@instances
  end

  debug 'Start interface' # вызывается как метод-класса, который подключен из Debugger::ClassMethods

  def initialize(number)
    @current_rpm = 0
    @@instances += 1
    @number = number
    debug 'Initialize' # это инстанс-метод, который подключается из Debugger::InstanceMethods
    validate!
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  debug 'End interface'

  protected

  attr_writer :current_rpm

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Number should be at least 6 symbols" if number.length < 6
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  # остановить двигатель
end

class MotorBike

  include FuelTank
  include Debugger

  debug 'MotorBike class'
end
