require 'rspec'
require 'rdd'

describe RDD::EventScorer do
  describe '#score' do
    it 'returns 10 for new repo' do
      event = RDD::V2Event.new('type' => 'RepositoryEvent')
      expect(RDD::EventScorer.call(event)).to eq(10)
    end

    it 'returns 5 for a forked repo' do
      event = RDD::V2Event.new('type' => 'ForkEvent')
      expect(RDD::EventScorer.call(event)).to eq(5)
    end

    it 'returns 3 for member added' do
      event = RDD::V2Event.new('type' => 'MemberEvent')
      expect(RDD::EventScorer.call(event)).to eq(3)
    end

    it 'returns 2 for a pull request closed and merged' do
      event = RDD::V2Event.new('type' => 'PullRequestEvent', 'payload' => { 'action' => "closed", 'pull_request' => { 'merged' => true } })
      expect(RDD::EventScorer.call(event)).to eq(2)
    end

    it 'returns 1 for a repo watched' do
      event = RDD::V2Event.new('type' => 'WatchEvent')
      expect(RDD::EventScorer.call(event)).to eq(1)
    end

    it 'returns 1 for issue created' do
      event = RDD::V2Event.new('type' => 'IssuesEvent', 'payload' => { 'action' => 'opened' })
      expect(RDD::EventScorer.call(event)).to eq(1)
    end

    it 'returns 0 for other events' do
      event = RDD::V2Event.new('type' => 'UnknownEvent')
      expect(RDD::EventScorer.call(event)).to eq(0)
    end
  end
end
