module ClientHelpers
  def stubs
    @stubs ||= Faraday::Adapter::Test::Stubs.new
  end

  def connection
    Faraday.new do |connection|
      connection.request :json
      connection.response :json, content_type: /\bjson$/
      connection.adapter :test, stubs
    end
  end
end
