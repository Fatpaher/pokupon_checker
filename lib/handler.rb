require_relative 'status_request'
class Handler
  attr_reader :previous_data, :requester, :report_sender

  def initialize(previous_data: {}, requester:, report_sender:)
    @previous_data = previous_data
    @requester = requester || StatusRequest.new
    @report_sender = report_sender || ReportSender.new
  end

  def call
    statuses = requester.call

    statuses.each do |url, status|
      next if previous_data[url].nil? || previous_data[url] == status

      report_sender.send(url, status)
    end
  end
end
