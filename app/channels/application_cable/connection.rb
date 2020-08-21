module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if verified_user = env['warden'].user(authenticated_scope)
        verified_user
      elsif verified_user = authenticate_from_token
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def authenticate_from_token
      token_from_params = request.params[:token]
      token_body = AuthenticationToken.decode(token_from_params.try(:squish))
      token = AuthenticationToken.find_for_context('staff', token_body)
      token.try(:user)
    end

    def authenticated_scope
      %i[vista_admin admin staff_member user].find do |scope|
        env['warden'].authenticated?(scope)
      end
    end
  end
end
