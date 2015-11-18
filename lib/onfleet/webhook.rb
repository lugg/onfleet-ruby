module Onfleet
  class Webhook < Base
    autoload :Payload, "onfleet/webhook/payload"

    # http://docs.onfleet.com/docs/webhooks#create-webhook
    def self.create(params = {})
      response = post "webhooks", params
      new(response)
    end

    # http://docs.onfleet.com/docs/webhooks#create-webhook
    def self.all
      response = get "webhooks"
      new(response)
    end

    # http://docs.onfleet.com/docs/webhooks#delete-webhook
    def self.delete(id)
      !!delete("webhooks/#{id}")
    end
  end
end
