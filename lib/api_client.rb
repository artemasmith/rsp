require 'net/http'

class ApiClient
  def initialize(url=nil)
    @url = url || ENV['throw_url'] || SRP_CONFIG['url']
  end

  attr_reader :url

  def get_throw
    unparsed_result = get_request
    result = JSON.parse(unparsed_result)
    body = result.dig('body')

    return false unless body
    body
  rescue JSON::ParserError
    false
  end

  private

  def get_request
    Net::HTTP.get(URI(url))
  # FYI: for any net errors without listing all the Net::HTTP possible errors, just return simple hash
  rescue => e
    Rails.logger.warn("Can't get throw #{e.message}")
    { code: 500 }
  end
end
