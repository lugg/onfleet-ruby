module Onfleet
  class Administrator < Base
    # http://docs.onfleet.com/docs/administrators#create-new-administrator
    def self.create(params = {})
      response = post "administrators", params
      new(response)
    end

    # http://docs.onfleet.com/docs/administrators#list-administrators
    def self.all
      response = get "administrators"
      new(response)
    end

    # http://docs.onfleet.com/docs/administrators#update-administrator
    def self.update(id, params = {})
      response = put "administrators/#{id}", params
      new(response)
    end

    # http://docs.onfleet.com/docs/administrators#delete-administrator
    def self.destroy(id)
      !!delete("administrators/#{id}")
    end

    # http://docs.onfleet.com/docs/metadata#querying-by-metadata
    def self.metadata(entries = [])
      response = post "administrators/metadata", entries
      new(response)
    end
  end
end
