module Scene
  class Base
    def self.setup_scene
      this.registered_handlers ||= []
    end

    def self.leave_scene
      puts "leaving menu - deregistering handlers '#{this.registered_handlers}'"
      this.registered_handlers.each do |id|
        ::Drive.deregister_handler(id)
      end
    end

    def self.enter_scene
    end
  end
end
