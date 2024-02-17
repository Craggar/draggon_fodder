module DriveHandlers
  module Object
    class Click < ::DriveHandlers::Base
      include Attributes::Object
      include Behaviours::Click
    end
    class Hover < ::DriveHandlers::Base
      include Attributes::Object
      include Behaviours::Hover
    end
  end
end