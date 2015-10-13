require 'thread'
require 'ruby-progressbar'

module RDD
  class ArchivesFetcher
    attr_accessor :start_time, :end_time, :limit, :thread_pool

    def self.call(start_time, end_time, thread_pool=4)
      new(start_time, end_time, thread_pool).call  
    end

    def initialize(start_time, end_time, thread_pool=4)
      @start_time = start_time
      @end_time = end_time
      @thread_pool = thread_pool
    end

    def call
      archives_q = needed_archive_names
      progress_bar = ProgressBar.create(total: archives_q.size)
      archive_scores = Queue.new
      threads = 1.upto(thread_pool).map do |i|
        t = Thread.new do
          begin
            while true do
              archive_name = archives_q.pop(true)
              scores = Archive.call(archive_name, start_time, end_time)
              archive_scores << scores
              progress_bar.increment
            end
          rescue ThreadError
          end
        end
      end
      threads.map(&:join)
      {}.tap { |scores|
        archive_scores.size.times do
          scores.merge!(archive_scores.pop) { |k, oldval, newval|
            oldval + newval
          }
        end
      }
    end

    private

    def needed_archive_names
      Queue.new.tap { |archive_names|
        start = start_time
        begin
          archive_names << start.strftime("%Y-%m-%d-%-H")
        end while (start += 3600) <= end_time
      }
    end
  end
end
