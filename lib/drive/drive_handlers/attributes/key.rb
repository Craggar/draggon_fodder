module DriveHandlers
  module Attributes
    module Key
      attr_reader :action, :key

      def serialize
        {
          id: id,
          enabled: enabled,
          last_ticked: last_ticked,
          action: action,
          key: key,
          callback: callback
        }
      end

      private

      def init_from_hash(opts:)
        @action = opts[:action]
        @key = opts[:key]
      end

      def init_from_array(opts:)
        @action = opts[0]
        @key = opts[1]
      end

      def pressed?(args)
        key_pressed = args.inputs.keyboard.send(action).send(key)
        key_pressed
      end
    end
  end
end
