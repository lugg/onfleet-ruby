require "nestful"
require "onfleet/version"

module Onfleet
  def self.key=(value)
    Base.key = value
  end

  def self.key
    Base.key
  end

  def self.key!
    key || raise("Onfleet.key not set")
  end

  autoload :Base, "onfleet/base"
  autoload :Resource, "onfleet/resource"
  autoload :Mash, "onfleet/mash"
  autoload :Organization, "onfleet/organization"
  autoload :Administrator, "onfleet/administrator"
  autoload :Worker, "onfleet/worker"
  autoload :Team, "onfleet/team"
  autoload :Destination, "onfleet/destination"
  autoload :Task, "onfleet/task"
  autoload :Recipient, "onfleet/recipient"
  autoload :Webhook, "onfleet/webhook"

  if onfleet_key = ENV["ONFLEET_KEY"]
    Onfleet.key = onfleet_key
  end
end
