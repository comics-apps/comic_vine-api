require 'comic_vine/api/http_service'
require 'comic_vine/api/version'

module ComicVine
  class Api
    class << self
      attr_accessor :http_service
    end

    self.http_service = HTTPService

    DEFAULT_SERVER = 'comicvine.gamespot.com'.freeze

    attr_reader :api_key, :options

    def initialize(api_key, options = {})
      @api_key = api_key
      @options = options
    end
  end
end
