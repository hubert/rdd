require 'open-uri'
require 'zlib'
require 'json'

module RDD
  class Archive
    def self.call(archive_name, start_time=nil, end_time=nil)
      {}.tap do |scores|
        begin
          gz = open("http://data.githubarchive.org/#{archive_name}.json.gz")
          Zlib::GzipReader.new(gz).each do |j|
            event = EventFactory.call(JSON.parse(j))
            event_created_at = event.created_at
            if (start_time && event_created_at < start_time) ||
              (end_time && event_created_at > end_time)
              next
            end

            event_score = EventScorer.call(event)
            if event_score > 0
              scores.merge!(event.repo_name => event_score) { |key, oldval, newval|
                oldval + newval
              }
            end
          end
        rescue OpenURI::HTTPError
          warn("WARN: #{archive_name} not available")
        end
      end
    end
  end
end
