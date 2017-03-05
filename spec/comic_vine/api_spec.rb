RSpec.describe ComicVine::Api do
  it 'has an http_service accessor' do
    expect(ComicVine::Api).to respond_to(:http_service)
    expect(ComicVine::Api).to respond_to(:http_service=)
  end

  describe 'constants' do
    it 'has a version' do
      expect(ComicVine::Api.const_defined?('VERSION')).to be_truthy
    end

    it 'has a filled default server' do
      expect(ComicVine::Api.const_defined?('DEFAULT_SERVER')).to be_truthy
      expect(ComicVine::Api::DEFAULT_SERVER).to eq('comicvine.gamespot.com')
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

  it 'return response for types request' do
    api_key = 'qwerty'
    service = ComicVine::Api.new(api_key)
    response = nil
    VCR.use_cassette('types') do
      response = service.types
    end

    expect(response).to be_a(ComicVine::Api::Response)
    expect(response.status).to eq(200)
    expect(response.error).to eq('OK')
    expect(response.status_code).to eq(1)
    expect(response.results).to be_an(Array)
    expect(response.results).not_to be_empty
    expect(response.version).to eq('1.0')
  end
end
