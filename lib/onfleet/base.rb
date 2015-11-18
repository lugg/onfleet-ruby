module Onfleet
  class Base < Resource
    endpoint "https://onfleet.com"
    path "api/v2"
    options format: :json

    def self.key=(value)
      add_options auth_type: :basic,
                  user: value

      @key = value
    end

    def self.key
      @key
    end
  end
end
