class Game
  include UsesState
  include Scenic

  def self.tick
    render
  end

  private

  def self.render
  end

  def self.setup_scene
    return if this.setup_done

    puts "performing game setup"
    this.setup_done = true
  end

  def self.this
    state.game
  end

  def self.leave_scene
    super
  end

  def self.enter_scene
    super
  end

  def self.leave_scene
  end

  def self.enter_scene
  end
end
