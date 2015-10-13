require 'rspec'
require 'rdd/v1_event'

describe RDD::V1Event do
  describe '#repo_name' do
    it 'returns repository full name if present' do
      event = RDD::V1Event.new('repository' => { 'full_name' => 'foo/bar' })
      expect(event.repo_name).to eq 'foo/bar'
    end

    it 'extracts repo name from url if repository full name missing' do
      event = RDD::V1Event.new('url' => 'https://github.com/baz/qux')
      expect(event.repo_name).to eq 'baz/qux'
    end
  end
end
