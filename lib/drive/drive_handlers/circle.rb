module DriveHandlers
  module Circle
    class Click < ::DriveHandlers::Base
      include Attributes::Circle
      include Behaviours::Click
    end
    class Hover < ::DriveHandlers::Base
      include Attributes::Circle
      include Behaviours::Hover
    end
  end
end