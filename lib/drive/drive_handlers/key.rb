module DriveHandlers
  module Key
    class Key < ::DriveHandlers::Base
      include Attributes::Key
      include Behaviours::Key
    end
  end
end
