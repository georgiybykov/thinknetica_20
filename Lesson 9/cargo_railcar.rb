# frozen_string_literal: true

require_relative 'validation'
require_relative 'railcar'

class CargoRailcar < RailCar
  include Validation

  attr_reader :overall_volume, :booked_volume

  validate :overall_volume, :presence
  validate :overall_volume, :type, Integer

  def initialize(overall_volume = 95)
    @type = 'cargo'
    @overall_volume = overall_volume
    @booked_volume = 0
    validate!
  end

  def take_volume(volume)
    return if volume > @overall_volume

    @booked_volume += volume if available_volume >= volume
  end

  def available_volume
    @overall_volume - @booked_volume
  end

  protected

  def validate!
    raise 'Overall volume must be greater than 0' if overall_volume.zero?
  end
end
