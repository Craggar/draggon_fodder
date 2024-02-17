module DriveHandlers
  module Behaviours
    module Click
      def triggered?(args)
        args.inputs.mouse.click && inside?(args)
      end
    end
  end
end
