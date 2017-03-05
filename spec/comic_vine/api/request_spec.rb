require 'spec_helper'

RSpec.describe ComicVine::Api::Request do
  let(:path) { 'foo' }
  let(:args) { { 'a' => 2, 'b' => 3, 'access_token' => 'a_token' } }
  let(:options) { { an: :option } }
  let(:request) do
    ComicVine::Api::Request.new(path: path, args: args, options: options)
  end

  it 'raises an ArgumentError if no path is supplied' do
    expect { ComicVine::Api::Request.new }.to raise_exception(ArgumentError)
  end

  describe '#verb' do
    it 'returns get' do
      expect(request.verb).to eq('get')
    end
  end

  describe '#path' do
    it 'returns the path' do
      expect(request.path).to eq('/api/foo/')
    end
  end

  describe '#args' do
    it 'returns the args provided' do
      expect(request.args).to include(args)
    end
  end

  describe '#options' do
    it 'returns the options provided' do
      expect(request.options).to include(options)
    end
  end

  describe '#server' do
    it 'returns default server' do
      expect(request.server).to eq('http://comicvine.gamespot.com')
    end
  end
end
