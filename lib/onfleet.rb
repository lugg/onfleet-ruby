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

  autoload :Base,     "onfleet/base"
  autoload :Resource, "onfleet/resource"
  autoload :Task,     "onfleet/task"
  autoload :Mash,     "onfleet/mash"

  if onfleet_key = ENV["ONFLEET_KEY"]
    Onfleet.key = onfleet_key
  end
end
