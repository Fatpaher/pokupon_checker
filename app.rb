require_relative 'config/init'
last_ran_at = Time.now
request_data = {}

while true do
  run_time = Time.now
  if (run_time - last_ran_at).to_i >= 1
    handler = StatusTracker.new(previous_data: request_data)
    handler.call
    request_data = handler.request_data
    last_ran_at = run_time
  end
end
