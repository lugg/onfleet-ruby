module Onfleet
  class Team < Base
    # http://docs.onfleet.com/docs/teams#list-teams
    def self.all
      response = get "teams"
      new(response)
    end

    # http://docs.onfleet.com/docs/teams#get-single-team
    def self.retrieve(id)
      response = put "teams/#{id}"
      new(response)
    rescue Errors::ResourceNotFound
    end
  end
end
