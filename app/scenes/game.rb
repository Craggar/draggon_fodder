module Scene
  class Game < Base
    include UsesState

    def self.tick
      render
    end

    private

    def self.render
    end

    def self.setup_scene
      return if this.setup_done
      puts "performing game setup"
      super
      this.setup_done = true
    end

    def self.this
      state.game
    end
  end
end
