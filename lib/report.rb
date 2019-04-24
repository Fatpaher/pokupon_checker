require 'net/smtp'
require 'mail'

class Report
  FROM = 'email@example.com'.freeze
  TO = 'alert@pokupon.ua'.freeze
  HOST = 'localhost'.freeze

  def send(url, status, old_status)
    subject = 'Pokupon_checker. Status changed'
    body = "#{url} changed status from #{old_status} to #{status}"

    send_email(subject, body)
  end

  private

  def send_email(subject, body)
    Mail.deliver do
      to TO
      from FROM
      subject subject
      body body
    end
  end
end
