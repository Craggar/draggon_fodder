require "app/require.rb"

class Main
  attr_accessor :args, :scene,
    :initial_setup_done, :menu_setup_done, :game_setup_done

  SCENE_CLASSES = {
    menu: ::Scene::Menu,
    game: ::Scene::Game,
    map_edit: ::Scene::MapEdit
  }

  def tick
    setup
    ::Drive.tick(args)
    SCENE_CLASSES[scene]&.tick
  end

  def setup
    return if initial_setup_done

    puts "performing setup"
    ::Drive.enable_logging

    args.state.video_config = args.state.new_entity_strict(
      :video_config,
      w: 1280,
      h: 720
    )

    swap_scene(:menu)
    self.initial_setup_done = true
  end

  def swap_scene(next_scene)
    puts "exiting #{scene} and entering #{next_scene}"
    SCENE_CLASSES[scene]&.leave_scene
    self.scene = next_scene
    SCENE_CLASSES[scene]&.setup_scene
    SCENE_CLASSES[scene]&.enter_scene
  end
end

$execution = Main.new

def tick(args)
  $execution.args = args
  $execution.tick
end
