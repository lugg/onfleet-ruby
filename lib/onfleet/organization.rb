module Onfleet
  class Organization < Base
    # http://docs.onfleet.com/docs/organizations#get-details
    # http://docs.onfleet.com/docs/organizations#get-delegatee-details
    def self.retrieve(id = nil)
      if id
        path = "organizations/#{id}"
      else
        path = "organization"
      end
      response = get path
      new(response)
    rescue Nestful::ResourceNotFound
    end
  end
end
