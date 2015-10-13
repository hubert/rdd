module RDD
  class V1Event 
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def type
      t = data.fetch('type')
      if t == 'PullRequestEvent' &&
        action == 'closed' &&
        data.fetch('payload').fetch('pull_request')['merged']
        'MergedPullRequestEvent'
      else
        if t == 'IssuesEvent'
         action == 'opened' ? 'OpenedIssueEvent' : 'ClosedIssueEvent'
        else
          t
        end
      end

      rescue KeyError => e
        warn("WARN: UnprocessableEvent #{e.message}")
        'UnprocessableEvent'
    end

    def action
      data.fetch('payload').fetch('action')
    end

    def repo_name
      data.fetch('repository', {})['full_name'] ||
        data.fetch('repo')['name'] ||
        URI(data['url']).path.slice(1..-1)
    end

    def created_at
      Time.parse(data.fetch('created_at')).utc
    end
  end
end
