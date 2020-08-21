# frozen_string_literal: true

class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  # @param [Object] data
  # @return [Object]
  def execute(data)
    query = data['query']
    variables = ensure_hash(data['variables'])
    operation_name = data['operationName']
    context = {
      # current_user: current_user,
      # Make sure the channel is in the context
      channel: self
    }

    current_branch_id = variables['branchId'].to_i

    branch_ids = if current_user.admin?
                   current_user.organisation.branches.pluck(:id)
                 else
                   current_user.assigned_branches.pluck(:id)
                 end

    if branch_ids.include?(current_branch_id)
      context[:current_branch_id] = current_branch_id
    end

    context[:current_user_id] = current_user.id

    result = VistaPlatformSchema.execute(
      query: query,
      context: context,
      variables: variables,
      operation_name: operation_name
    )

    payload = {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?
    }

    # Track the subscription here so we can remove it
    # on unsubscribe.
    if result.context[:subscription_id]
      @subscription_ids << context[:subscription_id]
    end

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |sid|
      VistaPlatformSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def ensure_hash(query_variables)
    if query_variables.blank?
      {}
    elsif query_variables.is_a?(String)
      JSON.parse(query_variables)
    else
      query_variables
    end
  end
end
