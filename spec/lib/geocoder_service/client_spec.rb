describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.post('geocode') { [status, headers, body.to_json] }
  end

  describe '#coordinates valid city' do
    let(:status) { 200 }
    let(:body) { [55.7540471, 37.620405].to_json  }

    it 'returns valid coordinates' do
      expect(subject.coordinates('valid.city')).to eq(JSON.parse(body))
    end
  end

  describe '#coordinates invalid city' do
    let(:status) { 204 }
    let(:body) { nil.to_json }

    it 'returns invalid coordinates' do
      expect(subject.coordinates('invalid.city')).to eq(JSON.parse(body))
    end
  end
end
