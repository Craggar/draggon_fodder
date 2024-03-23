module Scene
  class MapEdit < Base
    include UsesState

    def self.tick
      render
    end

    def self.render
    end

    def self.this
      state.map_edit
    end
  end
end
