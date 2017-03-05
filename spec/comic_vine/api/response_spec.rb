require 'spec_helper'

RSpec.describe ComicVine::Api::Response do
  describe '#data' do
    # it "parses the JSON if there's a body" do
    #   result = { 'foo' => 'bar' }
    #   response = ComicVine::Api::Response.new(
    #     double(:response, status: 200, body: result.to_json, headers: {})
    #   )
    #   expect(response.data).to eq(result)
    # end

    # it "raises a ParserError if it's invalid JSON" do
    #   response = ComicVine::Api::Response.new(
    #     double(:response, status: 200, body: '{', headers: {})
    #   )
    #   expect { response.data }.to raise_exception(JSON::ParserError)
    # end
  end
end
