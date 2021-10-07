module GeocoderService
  module Api
    def coordinates(city)
      response = connection.post('geocode') do |request|
        request.params['city'] = city
      end
      response.success? ? JSON.parse(response.body) : nil
    end
  end
end
