module Api
  module Partners
    module V1
      class GraphqlController < Api::Partners::V1::BaseController
        skip_before_action :convert_params_to_snakecase

        def execute
          variables = ensure_hash(permitted_params[:variables])
          query = permitted_params[:query]
          operation_name = permitted_params[:operationName]
          context = {
            token_context: token_context,
            current_branch: current_branch,
            current_branch_id: current_branch_id,
            current_organisation: current_organisation,
            current_user: current_user,
            current_role: current_role,
            request: request
          }
          result = VistaPlatformSchema.execute(
            query,
            variables: variables,
            context: context,
            operation_name: operation_name
          )
          render json: result
        end

        private

        # Handle form data, JSON body, or a blank value
        def ensure_hash(ambiguous_param)
          case ambiguous_param
          when String
            if ambiguous_param.present?
              ensure_hash(JSON.parse(ambiguous_param))
            else
              {}
            end
          when Hash, ActionController::Parameters
            ambiguous_param
          when nil
            {}
          else
            raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
          end
        end

        # TODO: get this working with unknown nested `variables` hash
        def permitted_params
          params.permit!
        end
      end
    end
  end
end
