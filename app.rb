require 'rubygems'
require_relative 'lib/handler'
require_relative 'lib/status_request'
require_relative 'lib/report_sender'

last_ran_at = Time.now

# while true do
#   run_time = Time.now
#   if (run_time - last_ran_at).to_i >= 1
#     Handler.new.call
#     last_ran_at = run_time
#   end
# end
