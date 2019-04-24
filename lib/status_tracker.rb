require_relative 'status_request'
class StatusTracker
  attr_reader :previous_data, :request, :report

  def initialize(options={})
    @previous_data = options[:previous_data] || {}
    @request = options[:request] || StatusRequest.new
    @report = options[:report] || Report.new
  end

  def call
    request_data.each do |url, status|
      previous_status = previous_data[url]
      next unless previous_status
      next if previous_data[url] == status

      report.send(url, status, previous_data[url])
    end
  end

  def request_data
    @request_data ||= request.call
  end
end
