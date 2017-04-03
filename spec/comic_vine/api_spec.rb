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
      expect(ComicVine::Api::DEFAULT_SERVER)
        .to eq('https://comicvine.gamespot.com')
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
    VCR.use_cassette('types') do
      service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])
      response = service.types
      expect(response).to be_a(ComicVine::Api::Response)
      expect(response.status).to eq(200)
      expect(response.error).to eq('OK')
      expect(response.status_code).to eq(1)
      expect(response.results).to be_an(Array)
      expect(response.results).not_to be_empty
      expect(response.version).to eq('1.0')
    end
  end

  it 'return response for search request' do
    VCR.use_cassette('search') do
      service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])
      response = service.search(query: 'flinstones')
      expect(response).to be_a(ComicVine::Api::Response)
      expect(response.status).to eq(200)
      expect(response.error).to eq('OK')
      expect(response.status_code).to eq(1)
      expect(response.results).to be_an(Array)
      expect(response.version).to eq('1.0')
    end
  end

  context 'defines' do
    let(:collection_methods) do
      %i[
        characters chats concepts episodes issues locations movies objects
        origins people powers promos publishers series_list story_arcs teams
        videos video_types video_categories volumes
      ]
    end

    let(:entity_methods) do
      %i[
        character chat concept episode issue location movie object
        origin person power promo publisher series story_arc team
        video video_type video_category volume
      ]
    end

    let(:dynamic_methods) do
      collection_methods + entity_methods
    end

    it 'dynamic methods by default' do
      service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])
      dynamic_methods.each do |dynamic_method|
        expect(service).to respond_to(dynamic_method)
      end
    end

    it 'dynamic methods from api' do
      service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])

      api_methods = []
      VCR.use_cassette('types') do
        api_methods += service.types.results.map do |result|
          [result['detail_resource_name'], result['list_resource_name']]
        end.flatten
      end

      VCR.use_cassette('types') do
        service.redefine_api_methods
      end

      api_methods.each do |api_method|
        expect(service).to respond_to(api_method)
      end
    end

    context 'dynamic collection method' do
      it 'and checks responses' do
        service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])

        collection_methods.each do |method_name|
          VCR.use_cassette(method_name) do
            response = service.send(
              method_name, limit: 1, sort: 'id', field_list: 'api_detail_url'
            )
            expect(response).to be_a(ComicVine::Api::Response)
            expect(response.status).to eq(200)
            expect(response.error).to eq('OK')
            expect(response.status_code).to eq(1)
            expect(response.results).to be_an(Array)
            expect(response.version).to eq('1.0')
          end
        end
      end
    end

    context 'dynamic entity method' do
      let(:ids) do
        {
          character_id: 1_253,
          chat_id: nil,
          concept_id: 35_070,
          episode_id: 1,
          issue_id: 6,
          location_id: 21_766,
          movie_id: 1,
          object_id: 15_073,
          origin_id: 1,
          person_id: 1_251,
          power_id: 1,
          promo_id: 1_743,
          publisher_id: 4,
          series_id: 1,
          story_arc_id: 27_758,
          team_id: 1_800,
          video_id: 1,
          video_type_id: 7,
          video_category_id: 7,
          volume_id: 766
        }
      end

      it 'and checks dynamic collection method responses' do
        service = ComicVine::Api.new(ENV['COMIC_VINE_API_KEY'])

        entity_methods.each do |method_name|
          id = ids[:"#{method_name}_id"]
          next unless id
          VCR.use_cassette("#{method_name}_#{id}") do
            response = service.send(method_name, id,
                                    field_list: 'api_detail_url')
            expect(response).to be_a(ComicVine::Api::Response)
            expect(response.status).to eq(200)
            expect(response.error).to eq('OK')
            expect(response.status_code).to eq(1)
            expect(response.results).to be_an(Hash)
            expect(response.version).to eq('1.0')
          end
        end
      end
    end
  end
end
