require 'json'

require 'comic_vine/api/api_methods'
require 'comic_vine/api/http_service'
require 'comic_vine/api/request'
require 'comic_vine/api/response'
require 'comic_vine/api/version'

module ComicVine
  class Api
    include ApiMethods

    class << self
      attr_accessor :http_service
    end

    self.http_service = HTTPService

    DEFAULT_SERVER = 'https://comicvine.gamespot.com'.freeze

    attr_reader :api_key, :options

    def initialize(api_key, options = {})
      @api_key = api_key
      @options = options

      initial_define_api_methods
    end

    def api_call(path, args, options = {})
      request = Request.new(
        path: path, args: args.merge(api_key: api_key), options: options
      )
      self.class.http_service.make_request(request)
    end
  end
end
