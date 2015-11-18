module Onfleet
  class Worker < Base
    # http://docs.onfleet.com/docs/workers#create-new-worker
    def self.create(params = {})
      response = post "workers", params
      new(response)
    end

    # http://docs.onfleet.com/docs/workers#list-workers
    def self.all(fields = [])
      if fields.empty?
        response = get "workers"
      else
        response = get "workers", filter: fields
      end
      new(response)
    end

    # http://docs.onfleet.com/docs/workers#get-single-worker
    # TODO: Add missing query param stuff.
    def self.retrieve(id)
      response = put "workers/#{id}"
      new(response)
    end

    # http://docs.onfleet.com/docs/workers#update-worker
    def self.update(id, params = {})
      response = put "workers/#{id}", params
      new(response)
    end

    # http://docs.onfleet.com/docs/workers#delete-worker
    def self.destroy(id)
      !!delete("workers/#{id}")
    end

    # http://docs.onfleet.com/docs/metadata#querying-by-metadata
    def self.metadata(entries = [])
      response = post "workers/metadata", entries
      new(response)
    end
  end
end
