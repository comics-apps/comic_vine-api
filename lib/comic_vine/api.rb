require 'comic_vine/api/http_service'
require 'comic_vine/api/version'

module ComicVine
  module Api
    class << self
      attr_accessor :http_service
    end

    self.http_service = HTTPService
  end
end
