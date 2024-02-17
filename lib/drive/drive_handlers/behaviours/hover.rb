module DriveHandlers
  module Behaviours
    module Hover
      def triggered?(args)
        inside?(args)
      end
    end
  end
end
