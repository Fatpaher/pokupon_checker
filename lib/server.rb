class Server
 REQUEST_INTERVAL = 60

 def self.run
  last_ran_at = Time.now
  request_data = StatusTracker.new.call

  loop do
   run_time = Time.now
   next if (run_time - last_ran_at).to_i < REQUEST_INTERVAL

   handler = StatusTracker.new(previous_data: request_data)
   handler.call

   request_data = handler.request_data
   last_ran_at = run_time
  end
 end
end
