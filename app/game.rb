class Game
  include UsesState

  def self.tick
    setup
    render
  end

  private

  def self.render
  end

  def self.setup
    return if this.setup_done

    puts "performing game setup"
    this.setup_done = true
  end

  def self.this
    state.game
  end
end
