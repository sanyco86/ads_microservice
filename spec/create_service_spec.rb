require 'spec_helper'

describe CreateService do
  subject { CreateService.new(params).call }

  let(:user_id) { 333 }
  let(:params) do
    ad_params.merge(user_id: user_id)
  end

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call }.to change(Ad, :count).by(1)
    end

    it 'assigns ad' do
      result = subject.call

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
      expect { subject.call }.not_to change(Ad, :count)
    end

    it 'assigns ad' do
      result = subject.call

      expect(result.ad).to be_kind_of(Ad)
    end
  end
end
