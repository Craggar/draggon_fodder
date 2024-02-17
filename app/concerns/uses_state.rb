class UsesState
  def args
    $execution.args
  end

  def state
    args.state
  end
end
