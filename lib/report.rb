require 'net/smtp'

class ReportSender
  FROM = 'email@example.com'.freeze
  # TO = 'alert@pokupon.ua'.freeze
  TO = 'fatpaher@gmail.com'.freeze
  HOST = 'localhost'.freeze


  def send(url, status, old_status)
    message = <<~MESSAGE
      From: <#{FROM}>
      To: <#{TO}>
      Subject: Pokupon_checker. Status changed

      #{url} changed status from #{old_status} to #{status}
    MESSAGE

    send_email(message)
  end

  private

  def send_email(message)
    Net::SMTP.start(HOST) do |smtp|
      smtp.send_message message, FROM, TO
    end
  end
end
