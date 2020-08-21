class RoleRequired
  def instrument(_type, field)
    return field unless field.metadata[:role_required]

    resolve_proc = authorization_proc(field)

    # Return a copy of `field`, with a new resolve proc
    field.redefine do
      resolve(resolve_proc)
    end
  end

  private

  def authorization_proc(field)
    # required_context = field.metadata[:role_required]
    original_resolve_proc = field.resolve_proc

    lambda { |obj, args, ctx|
      raise GraphQL::ExecutionError, :role_missing unless ctx[:current_role]

      original_resolve_proc.call(obj, args, ctx)
    }
  end
end
