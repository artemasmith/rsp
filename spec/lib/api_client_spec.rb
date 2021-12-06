require 'rails_helper'

class FakeResponse
  def initialize(code:, body: nil)
    @code = code
    @body = { 'body' => body }.to_json
  end

  attr_reader :code, :body
end

RSpec.describe ApiClient do
  before do
    allow_any_instance_of(ApiClient).to receive(:get_request).and_return(request_result)
  end
  let(:service) { described_class.new('http://test_url.com/throw')}

  describe 'When successful request' do
    let(:request_result) { FakeResponse.new(code: 200, body: 'rock') }

    it { expect(service.get_throw).to eq('rock') }
  end

  describe 'When request failes' do
    let(:request_result) { FakeResponse.new(code: 500) }

    it { expect(service.get_throw).to eq(false) }
  end
end
