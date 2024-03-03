module Processor
  class World
    include UsesState

    def self.tick(args)
    end

    def self.setup(level:)
      px_width = 2560
      px_height = 1440
      this.dimensions = state.new_entity_strict(
        :dimensions,
        x: 0,
        y: 0,
        w: px_width,
        h: px_height
      )
    end

    def self.this
      state.game.world
    end
  end
end
