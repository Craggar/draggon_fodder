module DriveHandlers
  module Attributes
    module Circle
      attr_reader :x, :y, :radius

      def serialize
        {
          id: id,
          enabled: enabled,
          last_ticked: last_ticked,
          x: x,
          y: y,
          radius: radius,
          mask: mask,
          callback: callback,
        }
      end

      private

      def init_from_hash(opts:)
        @x = opts[:x] || 0
        @y = opts[:y] || 0
        @radius = opts[:radius] || 0
      end

      def init_from_array(opts:)
        @x = opts.x || 0
        @y = opts.y || 0
        @radius = opts.w || 0
      end

      def inside?(args)
        inside = args.inputs.mouse.inside_circle?([mask.x, mask.y], mask[2]) 
        # Drive.log "Checking if #{args.inputs.mouse.point} in #{mask} - #{inside}"
        inside
      end

      def mask
        @mask ||= [x, y, radius]
      end
    end
  end
end