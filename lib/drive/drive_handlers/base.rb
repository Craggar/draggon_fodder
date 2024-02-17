module DriveHandlers
  class Base
    $ids = 0
    attr_reader :id, :callback, :last_ticked, :enabled

    def initialize(callback:, opts:)
      Drive.log "EventHandler ##{$ids + 1} init"
      init_from_hash(opts: opts) if opts.is_a?(Hash) 
      init_from_array(opts: opts) if opts.is_a?(Array) 
      generate_id
      @callback = callback
      @enabled = true
    end

    def init_from_hash(opts:); end

    def init_from_array(opts:); end

    def tick(args)
      trigger(args) if triggered?(args)
    end

    def toggle(state)
      Drive.log "Toggling #{state}"
      if state == :toggle
        @enabled = !enabled
      elsif state == :off
        @enabled = false
      elsif state == :on
        @enabled = true
      end
    end

    def serialize
      {
        id: id,
        enabled: enabled,
        last_ticked: last_ticked,
        callback: callback,
      }
    end

    def inspect
      serialize.to_s
    end

    def to_s
      serialize.to_s
    end

    private

    def generate_id
      @id = ($ids += 1)
    end

    def triggered?(args)
      false
    end

    def trigger(args)
      return unless callback && last_ticked != args.tick_count
      @last_ticked = args.tick_count
      callback.call
    end

    def inside?(args)
      false
    end

    def pressed?(args)
      false
    end
  end
end