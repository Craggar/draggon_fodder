module UsesState
  class << self
    def included(klass)
      klass.extend ClassMethods
    end
  end

  module ClassMethods
    def args
      $execution.args
    end

    def state
      $execution.args.state
    end

    def outputs
      $execution.args.outputs
    end
  end
end
