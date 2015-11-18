require "active_support/string_inquirer"

module Onfleet::Webhook
  class Payload < Mash
    # http://docs.onfleet.com/docs/webhooks
    TRIGGERS = %w(
      task_started
      task_eta
      task_arrival
      task_completed
      task_failed
      worker_duty
      task_created
      task_updated
      task_deleted
    )

    def initialize(env)
      request = Rack::Request.new(env)
      request.body.rewind

      body = request.body.read
      merge!(JSON.parse(body))
    end

    def trigger
      TRIGGERS[self["trigger"]].inquiry
    end
  end
end
