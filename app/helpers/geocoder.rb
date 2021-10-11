module Geocoder
  def coordinates
    geocoder_service.coordinates(city)
  end

  private

  def geocoder_service
    @geocoder_service ||= GeocoderService::Client.new
  end

  def city
    params.dig('ad', 'city')
  end
end
