# frozen_string_literal: true

# It should be called by `ruby handler.rb` from the terminal.

# gem install rack
require 'rack'

app = Proc.new do |env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    ["Welcome aboard!\n"]
  ]
end

Rack::Handler::WEBrick.run app
