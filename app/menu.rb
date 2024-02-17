class Menu
  include UsesState

  def self.tick
    setup
    render
  end

  def self.render
    outputs.labels << this.start_button.label
    outputs.solids << this.start_button.background
  end

  private

  def self.setup
    return if $execution.menu_setup_done

    puts "performing menu setup"
    create_buttons
    ::Drive.register_handler(
      event: :key,
      callback: method(:confirm_callback),
      opts: {
        action: :key_down,
        key: :space
      }
    )
    $execution.menu_setup_done = true
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
    ::Drive.register_handler(
      event: :hover,
      shape: :box,
      callback: method(:hover_callback),
      opts: this.start_button.background
    )
    ::Drive.register_handler(
      event: :click,
      shape: :box,
      callback: method(:click_callback),
      opts: this.start_button.background
    )
  end

  def self.hover_callback(opts = {})
  end

  def self.click_callback(opts = {})
    $execution.start_game
  end

  def self.confirm_callback(opts = {})
    puts "confirming #{opts}"
  end

  def self.this
    state.menu
  end
end
