require 'spec_helper'

describe Faces::Strategies::Default do
  let(:app){ Rack::Builder.new do |b|
    b.use Faces::Strategies::Default
    b.run lambda{|env| [200, {}, ['Not Found']]}
  end.to_app }

  subject do
    Faces::Strategies::Default.new(app, {default_src: 'http://example.com'})
  end

  describe '#src' do
    it 'returns the default image source' do
      expect(subject.src).to eq('http://example.com')
    end
  end
end