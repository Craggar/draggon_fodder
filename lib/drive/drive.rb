class Drive
  def self.register_handlers(callbacks:, store: nil, shape: nil, opts: {})
    Drive.log "Registering Handler for #{shape}, #{opts}, #{callbacks}"
    callbacks.map do |event, callback|
      handler = ::DriveHandlers.for(
        event: event,
        shape: shape,
        callback: callback,
        opts: opts
      )
      store_handler(event, handler)
      store << handler.id if store
    end
  end

  def self.deregister_handler(id)
    if hover_events.key?(id)
      Drive.log "Deregestering hover handler #{id}"
      storage[:hover_events].tap do |events|
        events.delete(id)
      end
    elsif click_events.key?(id)
      Drive.log "Deregestering click handler #{id}"
      storage[:click_events].tap do |events|
        events.delete(id)
      end
    elsif evt = key_event_from_id(id)
      Drive.log "Deregestering key handler #{id}"
      storage[:key_events].tap do |events|
        events[evt.key].delete(evt.action)
      end
    end
  end

  def self.toggle_handler(id, state: :toggle)
    if event = hover_events[id]
      event.toggle(state)
    elsif event = click_events[id]
      event.toggle(state)
    elsif event = key_events[id]
      event.toggle(state)
    end
  end

  def self.tick(args)
    hover_tick(args)
    click_tick(args)
    key_tick(args)
  end

  def self.enable_logging
    ensure_setup

    puts "Enabling DRiver logging"
    storage[:logging] = true
  end

  def self.log(message)
    return unless storage && storage[:logging]

    puts message
  end

  private

  def self.hover_tick(args)
    return unless hover_events.count.positive?

    # log "Checking hovers on #{hover_events.count} Events"
    hover_events.each do |_id, event|
      next unless event.enabled

      event.tick(args)
    end
  end

  def self.click_tick(args)
    return unless click_events.length.positive?
    return unless args.inputs.mouse.click

    log "Checking clicks on #{click_events.count} Events"
    click_events.each do |_id, event|
      next unless event.enabled

      event.tick(args)
    end
  end

  def self.key_tick(args)
    return unless key_events.length.positive?

    key_events.each do |key, actions|
      actions.each do |action, entry|
        event = entry[:event]
        next unless event.enabled

        event.tick(args)
      end
    end
  end

  def self.ensure_setup
    $gtk.args.state.driver ||= STORAGE_STRUCTURE
  end

  def self.click_events
    ensure_setup
    storage[:click_events]
  end

  def self.hover_events
    ensure_setup
    storage[:hover_events]
  end

  def self.key_events
    ensure_setup
    storage[:key_events]
  end

  def self.key_event_from_id(id)
    evt = nil
    key_events.each do |key, actions|
      next if evt
      actions.each do |action, entry|
        next if evt
        evt = entry[:event] if id == entry[:id]
      end
    end
    evt
  end

  def self.store_handler(type, event)
    if type == :click
      storage[:click_events][event.id] = event
    elsif type == :hover
      storage[:hover_events][event.id] = event
    elsif type == :key
      storage[:key_events][event.key] ||= {}
      storage[:key_events][event.key][event.action] = {
        id: event.id,
        event: event
      }
    end
  end

  def self.storage
    $gtk.args.state.driver
  end

  STORAGE_STRUCTURE = {
    click_events: {},
    hover_events: {},
    key_events: {},
    logging: false
  }
end
