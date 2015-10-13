require 'thor'
require 'time'
require 'benchmark'

module RDD
  class CLI < Thor
    ARCHIVE_START_DATE = Time.parse('2011-02-12T03:00:00-00:00').utc

    option :after,
      default: Time.now.utc - (28 * 24 * 3600),
      desc: 'Date to start search at, ISO8601 or YYYY-MM-DD format'
    option :before,
      :default => Time.now.utc,
      :desc => 'ISO8601 Date to end search at, ISO8601 or YYYY-MM-DD format'
    option :top,
      :type => :numeric,
      :default => 20,
      :desc => 'The number of repos to show'
    option :thread_pool,
      :type => :numeric,
      :default => 4,
      :desc => 'The number of threads to retieve and score archives'
    desc "score", "show most active repos"
    def score
      start_time = options[:after]
      start_time = Time.parse(options[:after]).utc if options[:after].is_a?(String)
      end_time = options[:before]
      end_time = Time.parse(options[:before]).utc if options[:before].is_a?(String)

      if start_time > end_time
        abort('ERROR: after cannot be greater then before')
      end

      if start_time < ARCHIVE_START_DATE
        warn('WARN: Github Archive not available before 2011-02-12, adjusting after to 2011-02-12')
        start_time = ARCHIVE_START_DATE
      end

      if end_time > Time.now.utc
        warn('WARN: Github Archive not available for the future, adjusting before to now')
        end_time = Time.now.utc
      end
      
      puts Benchmark.measure {
        scores = RDD::ArchivesFetcher.call(
          start_time, 
          end_time,
          options[:thread_pool]
        )
        scores.to_a.
          sort_by { |s| -s[1] }.slice(0, options[:top]).
          each_with_index do |(repo_name, score), i|
            puts "#%-6d: %-65s - %d points" % [i+1, repo_name, score]
          end
      }
    end
  end
end
