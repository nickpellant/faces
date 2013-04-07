require 'spec_helper'

describe Faces::Strategy do
  let(:fresh_strategy){ c = Class.new; c.send :include, Faces::Strategy; c}

  describe '.default_options' do
    it 'returns the default options' do
      fresh_strategy.option 'test', 'correct'
      expect(fresh_strategy.default_options).to eq(Faces::Strategies::Options.new({test: 'correct'}))
    end
  end

  describe '.option' do
    it 'sets an option for the strategy' do
      expect(fresh_strategy.default_options).to eq(Faces::Strategies::Options.new())      
      fresh_strategy.option 'test', 'correct'      
      expect(fresh_strategy.default_options).to eq(Faces::Strategies::Options.new({test: 'correct'}))
    end
  end

end