module DriveHandlers
  module Behaviours
    module Key
      def triggered?(args)
        pressed?(args)
      end
    end
  end
end
