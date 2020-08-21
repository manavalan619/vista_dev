class TokenContext
  def instrument(_type, field)
    return field if field.metadata[:token_context].blank?

    resolve_proc = authorization_proc(field)

    # Return a copy of `field`, with a new resolve proc
    field.redefine do
      resolve(resolve_proc)
    end
  end

  private

  def authorization_proc(field)
    required_context = field.metadata[:token_context]
    original_resolve_proc = field.resolve_proc

    lambda { |obj, args, ctx|
      if ctx[:token_context] != required_context
        raise GraphQL::ExecutionError, :forbidden
      end

      original_resolve_proc.call(obj, args, ctx)
    }
  end
end
