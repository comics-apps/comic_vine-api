RSpec.describe ComicVine::Api do
  it 'has an http_service accessor' do
    expect(ComicVine::Api).to respond_to(:http_service)
    expect(ComicVine::Api).to respond_to(:http_service=)
  end

  describe 'constants' do
    it 'has a version' do
      expect(ComicVine::Api.const_defined?('VERSION')).to be_truthy
    end
  end

  it 'has an attr_reader for api key' do
    api_key = 'adfadf'
    service = ComicVine::Api.new(api_key)
    expect(service.api_key).to eq(api_key)
  end

  it 'has an attr_reader for options with default value' do
    api_key = 'adfadf'
    service = ComicVine::Api.new(api_key)
    expect(service.options).to eq({})
  end

  it 'has an attr_reader for options with passed value' do
    api_key = 'adfadf'
    options = { proxy: 'localhost' }
    service = ComicVine::Api.new(api_key, options)
    expect(service.options).to eq(proxy: 'localhost')
  end
end
