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
    return if $execution.game_setup_done

    puts "performing game setup"
    $execution.game_setup_done = true
  end
end
