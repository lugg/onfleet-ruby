# Onfleet

A full featured Ruby API client to http://onfleet.com

# Usage

Set the API key

```ruby
Onfleet.key = ENV["ONFLEET_KEY"]
```

Do some stuff

```ruby
workers = Onfleet::Worker.all
worker  = workers.first

puts worker.phone

Onfleet::Worker.update(worker.id, name: "Eric")
```

See the [documentation](https://docs.onfleet.com) for more information.

### Modules

```ruby
Onfleet::Organization
Onfleet::Administrator
Onfleet::Worker
Onfleet::Team
Onfleet::Destination
Onfleet::Task
Onfleet::Recipient
Onfleet::Webhook
Onfleet::Webhook::Payload
```

### Todo
- [ ] Tests
- [ ] Better error handling
- [ ] camelCase keys to snake_case keys
