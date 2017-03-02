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
end
