module Processor
  class World
    include UsesState

    def self.tick(args)
    end

    def self.setup(level:)
      this.dimensions = state.new_entity_strict(
        :dimensions,
        x: 0,
        y: 0,
        w: 2560,
        h: 1440
      )
    end

    def self.this
      state.game.world
    end
  end
end
