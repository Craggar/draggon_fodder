module Scene
  class Menu < Base
    include UsesState

    def self.tick
      render
    end

    def self.render
      outputs.labels << this.start_button.label
      outputs.solids << this.start_button.background
    end

    private

    def self.setup_scene
      return if this.setup_done
      puts "performing game setup"
      super

      create_buttons
      ::Drive.register_handlers(
        callbacks: {
          key: method(:confirm_callback)
        },
        opts: {
          action: :key_down,
          key: :space
        },
        store: this.registered_handlers
      )
      this.menu_setup_done = true
    end

    def self.create_buttons
      this.start_button = state.new_entity(
        :button,
        x: 100,
        y: 100,
        w: 100,
        h: 50,
        label:  [100, 125, "Start", -2, 0, 0, 0, 0].label,
        background: [100, 100, 100, 50, 255, 255, 255].solid
      )
      ::Drive.register_handlers(
        shape: :box,
        callbacks: {
          hover: method(:hover_callback),
          click: method(:click_callback)
        },
        opts: this.start_button.background,
        store: this.registered_handlers
      )
    end

    def self.hover_callback(opts = {})
      puts "hovering #{opts}"
    end

    def self.click_callback(opts = {})
      puts "clicking #{opts}"
      $execution.swap_scene(:game)
    end

    def self.confirm_callback(opts = {})
      puts "confirming #{opts}"
    end

    def self.this
      state.menu
    end
  end
end
