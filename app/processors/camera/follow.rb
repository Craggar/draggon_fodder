module Camera
  class Follow
    include UsesState

    def self.render
      # args.render_target(:world).solids << [this.viewport.x, this.viewport.y, this.viewport.w, this.viewport.h, 192, 192, 192].solid

      outputs.sprites << {
        x: 0,
        y: 0,
        w: state.video_config.w,
        h: state.video_config.h,
        source_x: this.viewport.x,
        source_y: this.viewport.y,
        source_w: this.viewport.w,
        source_h: this.viewport.h,
        path: :world
      }

      outputs.labels << [20, 680, "Camera: #{this.viewport.x.to_i},#{this.viewport.y.to_i} [#{this.viewport.w.to_i}x#{this.viewport.h.to_i}]", 0, 255, 0, 0, 0].label

      world_render_target = args.render_target(:world)
      outputs.labels << [20, 700, "World: #{world_render_target.width.to_i},#{world_render_target.height.to_i}", 0, 255, 0, 0, 0].label
    end

    def self.tick
      return unless this.target

      update_follow_zone
      return if this.target.inside_rect?(this.follow_zone)

      this.viewport.x = (this.viewport.x + this.speed).clamp(0, world.dimensions.w - this.viewport.w) if this.target.x > this.follow_zone.x + this.follow_zone.w
      this.viewport.x = (this.viewport.x - this.speed).clamp(0, world.dimensions.w - this.viewport.w) if this.target.x < this.follow_zone.x
      this.viewport.y = (this.viewport.y + this.speed).clamp(0, world.dimensions.h - this.viewport.h) if this.target.y > this.follow_zone.y + this.follow_zone.h
      this.viewport.y = (this.viewport.y - this.speed).clamp(0, world.dimensions.h - this.viewport.h) if this.target.y < this.follow_zone.y
    end

    def self.update_follow_zone
      this.follow_zone = {
        x: this.viewport.x + this.viewport.w / 4,
        y: this.viewport.y + this.viewport.h / 4,
        w: this.viewport.w / 2,
        h: this.viewport.h / 2
      }
    end

    def self.follow(target)
      this.target = target
      this.speed = 2.1
    end

    def self.setup(opts = {})
      this.viewport = state.new_entity_strict(
        :viewport,
        x: opts[:x] || 0,
        y: opts[:y] || 0,
        w: opts[:w] || state.video_config.w,
        h: opts[:h] || state.video_config.h
      )
    end

    def self.this
      state.game.camera
    end

    def self.world
      state.game.world
    end
  end
end
