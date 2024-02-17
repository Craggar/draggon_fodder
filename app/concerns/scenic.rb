module Scenic
  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

  module ClassMethods
    def enter_scene
      puts "entering scene #{self}"
      # register all handlers
    end

    def leave_scene
      puts "exiting scene #{self}"
      # de-register all handlers
    end

    def setup_scene
      puts "setting up scene #{self}"
    end
  end
end
