module Geocoder
  def geocoder
    coordinates ||= geocoder_service.coordinates(city)
    { lat: coordinates.try(:[], 0), lon: coordinates.try(:[], 1) }
  end

  private

  def geocoder_service
    @geocoder_service ||= GeocoderService::Client.new
  end

  def city
    params.try(:[], 'ad').try(:[], 'city')
  end
end
