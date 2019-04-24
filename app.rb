require 'rubygems'
require_relative 'lib/status_tracker'
require_relative 'lib/status_request'
require_relative 'lib/report'
require 'mail'

last_ran_at = Time.now
request_data = {}

# while true do
#   run_time = Time.now
#   if (run_time - last_ran_at).to_i >= 1
#     handler = StatusTracker.new(previous_data: request_data)
#     handler.call
#     request_data = handler.request_data
#     last_ran_at = run_time
#   end
# end
