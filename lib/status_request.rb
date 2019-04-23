require "net/http"

class StatusRequest
  URLS = [
    'https://pokupon.ua/'.freeze,
    'https://partner.pokupon.ua/'.freeze,
  ].freeze

  def call
    URLS.each_with_object({}) do |url, result|
      uri = URI.parse(url)
      req = Net::HTTP.new(uri.host, uri.port)
      req.use_ssl = true
      responce = req.request_get(uri.path)
      result[url] = responce.code
    end
  end
end
