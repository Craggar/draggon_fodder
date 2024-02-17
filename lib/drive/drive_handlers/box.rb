module DriveHandlers
  module Box
    class Click < ::DriveHandlers::Base
      include Attributes::Box
      include Behaviours::Click
    end
    class Hover < ::DriveHandlers::Base
      include Attributes::Box
      include Behaviours::Hover
    end
  end
end