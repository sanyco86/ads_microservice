describe AdRoutes, type: :routes do
  describe 'GET /v1/ads' do
    let(:user_id) { 333 }

    before { create_list :ad, 3, user_id: user_id }

    it 'returns a collection of ads' do
      do_request

      expect(last_response.status).to eq 200
      expect(response_body['data'].size).to eq(3)
    end

    def do_request(params={})
      get '/v1/ads', params
    end
  end

  describe 'POST /v1/ads' do
    let(:user_id) { 333 }
    let(:city) { 'City' }

    let(:auth_token) { 'auth.token' }
    let(:auth_service) { instance_double('Auth service') }

    let(:coordinates) { { lat: 45.05, lon: 90.05 } }
    let(:geocoder_service) { instance_double('Geocoder service') }

    before do
      allow(auth_service).to receive(:auth).with(auth_token).and_return(user_id)
      allow(AuthService::Client).to receive(:new).and_return(auth_service)

      allow(geocoder_service).to receive(:coordinates).with(city).and_return(coordinates)
      allow(GeocoderService::Client).to receive(:new).and_return(geocoder_service)

      header 'Authorization', "Bearer #{auth_token}"
    end

    context 'missing parameters' do
      it 'returns an error' do
        do_request

        expect(last_response.status).to eq 422
      end
    end

    context 'missing user_id' do
      let(:user_id) { nil }

      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      it 'returns an error' do
        do_request ad: ad_params
        expect(last_response.status).to eq(403)
        expect(response_body['errors']).to include('detail' => 'Доступ к ресурсу ограничен')
      end
    end

    context 'invalid parameters' do
      let(:city) { '' }

      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        do_request(ad: ad_params)

        expect(last_response.status).to eq 422
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите город',
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { do_request(ad: ad_params) }.to change { Ad.count }.from(0).to(1)

        expect(last_response.status).to eq 201
      end

      it 'returns an ad' do
        do_request(ad: ad_params)

        expect(response_body['data']).to include(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end

    def do_request(params={})
      post 'v1/ads', params
    end
  end
end
