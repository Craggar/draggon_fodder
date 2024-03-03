module Scene
  class Game < Base
    include UsesState

    def self.tick
      this.camera_class.tick
      p = ::Processor::Players.this.active_players.first
      if args.inputs.keyboard.key_held.d
        p.x += 4
        puts "moving right"
      end
      if args.inputs.keyboard.key_held.a
        p.x -= 4
        puts "moving left"
      end
      if args.inputs.keyboard.key_held.w
        p.y += 4
        puts "moving up"
      end
      if args.inputs.keyboard.key_held.s
        p.y -= 4
        puts "moving down"
      end
      render
    end

    def self.render
      args.render_target(:world).sprites << ::Processor::Players.this.active_players

      args.render_target(:world).labels << ::Processor::Players.this.active_players.map do |p|
        [p.x, p.y, p.text, 0, 255, 0, 0, 0].label
      end

      this.camera_class.render
    end

    def self.setup_scene
      return if this.setup_done
      puts "performing game setup"
      super

      this.current_level ||= :one

      ::Processor::Players.setup_roster
      ::Processor::Players.setup(level: this.current_level)

      ::Processor::World.setup(level: this.current_level)

      this.camera_class = ::Camera::Follow
      this.camera_class.setup

      this.camera_class.follow(::Processor::Players.this.active_players.first)

      this.setup_done = true
    end

    def self.this
      state.game
    end
  end
end
