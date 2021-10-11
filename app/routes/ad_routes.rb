class AdRoutes < Application
  helpers PaginationLinks, Auth, Geocoder

  namespace '/v1' do
    get '/ads' do
      page = params[:page].presence || 1
      ads = Ad.reverse_order(:updated_at)
      ads = ads.paginate(page.to_i, Settings.pagination.page_size)
      serializer = AdSerializer.new(ads.all, links: pagination_links(ads))

      status 200
      json serializer.serializable_hash
    end

    post '/ads' do
      create_params = validate_with!(AdParamsContract)
      result = Ads::CreateService.call(ad: create_params[:ad], user_id: user_id, coordinates: coordinates)

      if result.success?
        serializer = AdSerializer.new(result.ad)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.ad
      end
    end
  end
end
