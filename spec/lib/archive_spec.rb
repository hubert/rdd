require 'rspec'
require 'rdd'

describe RDD::Archive do
  describe '.call' do
    it 'ignores archives that cannot be retrieved' do
      # mostly necessary for searching for most recent archives
      # since github archive service lags a couple hours
      expect {
        RDD::Archive.call('foobar_archive')
      }.to_not raise_error
    end
  end
end
