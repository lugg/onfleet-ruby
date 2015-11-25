module Onfleet
  class Recipient < Base
    # http://docs.onfleet.com/docs/recipients#get-single-recipient
    def self.retrieve(id)
      response = get "recipients/#{id}"
      new(response)
    rescue Nestful::ResourceNotFound
    end

    # http://docs.onfleet.com/docs/recipients#create-new-recipient
    def self.create(params = {})
      response = post "recipients", params
      new(response)
    end

    # http://docs.onfleet.com/docs/recipients#find-recipient
    def self.find(phone: nil, name: nil)
      return unless phone || name

      if phone
        path = "recipients/phone/#{URI::encode(phone)}"
      elsif name
        path = "recipients/name/#{URI::encode(name)}"
      end

      response = get path, params
      new(response)
    end

    # http://docs.onfleet.com/docs/recipients#update-recipient
    def self.update(id, params = {})
      response = put "tasks/#{id}", params
      new(response)
    end

    # http://docs.onfleet.com/docs/metadata#querying-by-metadata
    def self.metadata(entries = [])
      response = post "recipients/metadata", entries
      new(response)
    end
  end
end
