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

    def self.setup_scene
      return if this.setup_done
      puts "performing menu setup"
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
      this.start_button = state.new_entity_strict(
        :button,
        x: 100,
        y: 100,
        w: 100,
        h: 50,
        label: {x: 100, y: 125, text: "Start", size_enum: -2, alignment_enum: 0, r: 0, g: 0, b: 0}.label,
        background: {x: 100, y: 100, w: 100, h: 50, r: 255, g: 255, b: 255}.solid
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
    end

    def self.click_callback(opts = {})
      $execution.swap_scene(:game)
    end

    def self.confirm_callback(opts = {})
      $execution.swap_scene(:game)
    end

    def self.this
      state.menu
    end
  end
end
