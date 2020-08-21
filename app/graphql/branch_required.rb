class BranchRequired
  def instrument(_type, field)
    return field unless field.metadata[:branch_required]

    resolve_proc = authorization_proc(field)

    # Return a copy of `field`, with a new resolve proc
    field.redefine do
      resolve(resolve_proc)
    end
  end

  private

  def authorization_proc(field)
    # required_context = field.metadata[:branch_required]
    original_resolve_proc = field.resolve_proc

    lambda { |obj, args, ctx|
      raise GraphQL::ExecutionError, :branch_missing unless ctx[:current_branch]

      original_resolve_proc.call(obj, args, ctx)
    }
  end
end
