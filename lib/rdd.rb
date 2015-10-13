require "rdd/version"

module RDD
  autoload :V1Event, 'rdd/v1_event'
  autoload :V2Event, 'rdd/v2_event'
  autoload :EventFactory, 'rdd/event_factory'
  autoload :EventScorer, 'rdd/event_scorer'
  autoload :Archive, 'rdd/archive'
  autoload :ArchivesFetcher, 'rdd/archives_fetcher'
end

require 'rdd/cli'
