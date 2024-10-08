module Scene
  class Game < Base
    include UsesState

    def self.tick
      this.camera_class.tick
      ::Processor::Players.tick
      render
    end

    def self.render
      world_render_target = args.render_target(:world)
      world_render_target.width = world.dimensions.w
      world_render_target.height = world.dimensions.h
      args.render_target(:world).sprites << ::Processor::Players.this.active_players

      args.render_target(:world).labels << ::Processor::Players.this.active_players.map do |p|
        {x: p.x, y: p.y, text: p.text, size_enum: 0, alignment_enum: 1, r: 255, g: 0, b: 0, a: 0}.label
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

      p = ::Processor::Players.this.active_players.first
      # p.queued_moves << [400, 750]
      # p.queued_moves << [1500, 1100]
      # p.queued_moves << [600, 200]

      this.setup_done = true
    end

    def self.this
      state.game
    end

    def self.world
      state.game.world
    end
  end
end
