module RDD
  class EventScorer
    def self.call(event)
      case event.type
      when 'RepositoryEvent'
        10
      when 'ForkEvent'
        5
      when 'MemberEvent'
        3
      when 'MergedPullRequestEvent'
        2
      when 'WatchEvent', 'OpenedIssueEvent'
        1
      else
        0
      end
    end
  end
end
