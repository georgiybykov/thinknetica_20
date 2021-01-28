# frozen_string_literal: true

# The command to execute from terminal is `rackup`.
# To send a request from another terminal: `curl --url "http://localhost:9292/" -i`

require_relative 'middleware/app_logger'
require_relative 'middleware/runtime'
require_relative 'app'

use Runtime
# Use `File.expand_path('log/app.log', __dir__)` to write logs to the current directory (`__dir__`).
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
