module DriveHandlers
  HANDLERS = {
    click: {
      circle: ::DriveHandlers::Circle::Click,
      circ: ::DriveHandlers::Circle::Click,
      box: ::DriveHandlers::Box::Click,
      object: ::DriveHandlers::Object::Click,
      obj: ::DriveHandlers::Object::Click
    },
    hover: {
      circle: ::DriveHandlers::Circle::Hover,
      circ: ::DriveHandlers::Circle::Hover,
      box: ::DriveHandlers::Box::Hover,
      object: ::DriveHandlers::Object::Hover,
      obj: ::DriveHandlers::Object::Hover
    },
    key: {
      event: ::DriveHandlers::Key::Key
    }
  }

  def self.for(event:, shape:, callback:, opts:)
    Drive.log "#{event}/#{shape}"
    return unless event_options = HANDLERS[event]

    if event == :key
      return HANDLERS[:key][:event].new(
        callback: callback,
        opts: opts
      )
    end

    klass = event_options[shape]
    klass.new(
      callback: callback,
      opts: opts
    )
  end
end
