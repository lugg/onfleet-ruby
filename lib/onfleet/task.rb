module Onfleet
  class Task < Base
    # http://docs.onfleet.com/docs/tasks#get-single-task
    def self.retrieve(id)
      response = get "tasks/#{id}"
      new(response)
    rescue Errors::ResourceNotFound
    end

    # http://docs.onfleet.com/docs/tasks#create-task
    def self.create(params = {})
      response = post "tasks", params
      new(response)
    end

    # http://docs.onfleet.com/docs/tasks#list-tasks
    def self.all(params = {})
      response = get "tasks", params
      new(response)
    end

    # http://docs.onfleet.com/docs/tasks#update-task
    def self.update(id, params = {})
      response = put "tasks/#{id}", params
      new(response)
    end

    # http://docs.onfleet.com/docs/tasks#complete-task
    def self.complete(id, params = {})
      !!post("tasks/#{id}/complete", completionDetails: params)
    end

    # http://docs.onfleet.com/docs/tasks#delete-task
    def self.destroy(id)
      !!delete("tasks/#{id}")
    end

    # http://docs.onfleet.com/docs/metadata#querying-by-metadata
    def self.metadata(entries = [])
      response = post "tasks/metadata", entries
      new(response)
    end
  end
end
