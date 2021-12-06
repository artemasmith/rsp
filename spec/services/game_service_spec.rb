require 'rails_helper'

RSpec.describe GameService do
  let(:rule_engine) { RuleEngine.new('scissors->paper;paper->rock;rock->scissors' ) }
  let(:service) { described_class.new(rule_engine) }

  describe 'When run succesfully' do
    let(:system_throw) { 'scissors' }
    before { allow_any_instance_of(described_class).to receive(:get_service_throw).and_return(system_throw) }

    it { expect(service.call('rock')).to eq('win') }
  end

  describe 'When service throw unavailable' do
    let(:possible_results) { ['tie', 'loose', 'win'] }
    before { allow_any_instance_of(ApiClient).to receive(:get_throw).and_return(false) }

    it { expect(possible_results).to include(service.call('rock')) }
  end
  
end
