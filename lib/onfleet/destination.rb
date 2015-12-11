module Onfleet
  class Destination < Base
    # http://docs.onfleet.com/docs/destinations#get-single-destination
    def self.retrieve(id)
      response = get "recipients/#{id}"
      new(response)
    rescue Onfleet::Errors::ResourceNotFound
    end

    # http://docs.onfleet.com/docs/destinations#create-new-destination
    def self.create(params = {})
      response = post "recipients", params
      new(response)
    end

    # http://docs.onfleet.com/docs/metadata#querying-by-metadata
    def self.metadata(entries = [])
      response = post "destinations/metadata", entries
      new(response)
    end
  end
end
