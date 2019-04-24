require_relative 'status_request'
class Handler
  attr_reader :previous_data, :request, :report

  def initialize(previous_data: {}, request: nil, report: nil)
    @previous_data = previous_data
    @request = request || StatusRequest.new
    @report = report || Report.new
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
