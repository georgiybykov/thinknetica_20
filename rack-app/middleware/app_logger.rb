# frozen_string_literal: true

require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    logger.info(env)

    app.call(env)
  end

  private

  attr_reader :logger, :app
end
