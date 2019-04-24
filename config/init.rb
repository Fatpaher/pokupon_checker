require_relative '../lib/status_tracker'
require_relative '../lib/status_request'
require_relative '../lib/report'
require_relative '../lib/server'

Mail.defaults do
  delivery_method :smtp, address: "localhost", port: 2500
end

