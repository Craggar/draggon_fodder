require "app/require.rb"

class Main
  attr_accessor :args, :scene,
    :initial_setup_done, :menu_setup_done, :game_setup_done

  def tick
    setup
    ::Drive.tick(args)
    if scene == :game
      Game.tick
    elsif scene == :menu
      Menu.tick
    end
  end

  def setup
    return if initial_setup_done

    puts "performing setup"
    self.scene = :menu
    ::Drive.enable_logging

    self.initial_setup_done = true
  end

  def start_game
    self.scene = :game
  end
end

$execution = Main.new

def tick(args)
  $execution.args = args
  $execution.tick
end
