module RDD
  class V2Event 
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def type
      t = data.fetch('type')
      if t == 'PullRequestEvent' &&
        action == 'closed' &&
        data.fetch('payload').fetch('pull_request').fetch('merged')
        'MergedPullRequestEvent'
      else
        if t == 'IssuesEvent'
         action == 'opened' ? 'OpenedIssueEvent' : 'ClosedIssueEvent'
        else
          t
        end
      end

      rescue KeyError
        puts 'WARN: UnknownEvent'
        'UnknownEvent'
    end

    def action
      data.fetch('payload').fetch('action')
    end

    def repo_name
      data.fetch('repo').fetch('name')
    end

    def created_at
      Time.parse(data.fetch('created_at')).utc
    end
  end
end
