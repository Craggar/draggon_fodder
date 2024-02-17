module DriveHandlers
  module Attributes
    module Box
      attr_reader :x, :y, :w, :h

      def serialize
        {
          id: id,
          enabled: enabled,
          last_ticked: last_ticked,
          x: x,
          y: y,
          w: w,
          h: h,
          mask: mask,
          callback: callback
        }
      end

      private

      def init_from_hash(opts:)
        @x = opts[:x] || 0
        @y = opts[:y] || 0
        @w = opts[:w] || 0
        @h = opts[:h] || 0
      end

      def init_from_array(opts:)
        @x = opts.x || 0
        @y = opts.y || 0
        @w = opts.w || 0
        @h = opts.h || 0
      end

      def inside?(args)
        args.inputs.mouse.inside_rect?(mask)
      end

      def mask
        @mask ||= [x, y, w, h]
      end
    end
  end
end
