require 'rails_helper'

RSpec.describe RuleEngine do
  let(:rules) { 'scissors->paper;paper->rock;rock->scissors' }
  let(:service) { described_class.new(rules) }

  describe 'When win' do
    let(:throw1) { 'rock' }
    let(:throw2) { 'scissors' }

    it { expect(service.parse(throw1, throw2)).to eq('win') }
  end

  describe 'When loose' do
    let(:throw1) { 'scissors' }
    let(:throw2) { 'rock' }

    it { expect(service.parse(throw1, throw2)).to eq('loose') }
  end

  describe 'When tie' do
    let(:throw1) { 'paper' }
    let(:throw2) { 'paper' }

    it { expect(service.parse(throw1, throw2)).to eq('tie') }
  end

  describe 'When invalid rules' do
    let(:rules) { 'just invalid data' }

    it { expect{described_class.new(rules)}.to raise_error(InvalidRules) }
  end

  describe 'When invalid throws' do
    let(:throw1) { 'not_a_throw' }
    let(:throw2) { 'temp' }

    it { expect{service.parse(throw1, throw2) }.to raise_error(ThrowParsingError) }
  end
end
