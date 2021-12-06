require 'rails_helper'

RSpec.describe ApiClient do
  before do
    allow_any_instance_of(ApiClient).to receive(:get_request).and_return(request_result)
  end
  let(:service) { described_class.new('http://test_url.com/throw')}

  describe 'When successful request' do
    let(:request_result) { { statusCode: 200, body: "rock" }.to_json }

    it { expect(service.get_throw).to eq('rock') }
  end

  describe 'When request failes' do
    let(:request_result) { { code: 500 }.to_json }

    it { expect(service.get_throw).to eq(false) }
  end
end
