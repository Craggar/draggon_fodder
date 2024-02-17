module DriveHandlers
  module Attributes
    module Object
      attr_reader :object, :type

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
          callback: callback,
        }
      end

      private

      def init_from_hash(opts:)
        @object = opts[:object]
        @type = opts[:type]
      end

      def init_from_array(opts:)
        @object = opts[0]
        @type = opts[1]
      end

      def inside?(args)
        if (type == :box)
          args.inputs.mouse.inside_rect?(mask)
        elsif type == :circle
          args.inputs.mouse.inside_circle?([mask.x, mask.y], mask[2])
        else
          false
        end
      end

      def mask
        if type == :box
          object
        elsif type == :circle
          [object.x + object.radius, object.y + object.radius, object.radius]
        end
      end
    end
  end
end
