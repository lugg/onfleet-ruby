require "rack"
require "json"
require "active_support/core_ext/string"

module Onfleet
  class Webhook
    class Payload < Mash
      def initialize(env)
        request = Rack::Request.new(env)
        request.body.rewind

        body = request.body.read
        merge!(JSON.parse(body))
      end

      # http://docs.onfleet.com/docs/webhooks
      def trigger
        triggerName.underscore.inquiry
      end
    end
  end
end
