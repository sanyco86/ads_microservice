require 'spec_helper'

describe 'Ads controller' do
  describe 'GET' do
    before { do_request }

    describe 'return ad list' do
      it 'should allow accessing the home page and return ad list' do
        expect(last_response.status).to eq 200
        expect(last_response.body).not_to be_empty
      end
    end

    def do_request(params={})
      get '/ads', params
    end
  end

  describe 'POST' do
    before { do_request params }

    context 'create ad' do
      let(:params) { { title: 'Test title', description: 'Test desc', city: 'New York', user_id: 1 } }

      it 'should create ad' do
        expect(last_response.status).to eq 200
        expect(last_response.body).not_to be_empty
      end
    end

    context 'create ad with error' do
      let(:params) { { title: 'Test title', description: 'Test desc', city: 'New York' } }

      it 'should get validation error' do
        expect(last_response.status).to eq 422
        expect(last_response.body).to eq "User can't be blank"
      end
    end

    def do_request(params={})
      post '/ads', params
    end
  end
end
