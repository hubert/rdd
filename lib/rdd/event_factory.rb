require 'rdd/v1_event'
require 'rdd/v2_event'

module RDD
  class EventFactory

    def self.call(event_data)
      if Time.parse(event_data.fetch('created_at')) >= Time.parse('2015-01-01T00:00:00-00:00').utc
        V2Event.new(event_data)
      else
        V1Event.new(event_data)
      end
    end
  end
end
