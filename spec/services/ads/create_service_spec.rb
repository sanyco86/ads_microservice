RSpec.describe Ads::CreateService do
  subject { described_class }

  let(:user_id) { 333 }
  let(:coordinates) { { lat: 45.05, lon: 90.05 } }

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, geocoder: coordinates) }.to change { Ad.count }.from(0).to(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, geocoder: coordinates)

      expect(result.ad).to be_kind_of(Ad)
    end
  end

  context 'invalid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: ''
      }
    end

    it 'does not create ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, geocoder: coordinates) }.not_to change { Ad.count }
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, geocoder: coordinates)

      expect(result.ad).to be_kind_of(Ad)
    end
  end
end
