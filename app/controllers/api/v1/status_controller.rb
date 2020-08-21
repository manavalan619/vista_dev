module Api::V1
  class StatusController < Api::V1::BaseController
    skip_before_action :authenticate

    def ping
      render json: 'Service available', status: 200
    end
  end
end
