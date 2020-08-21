module Api::V1
  class DevicesController < Api::V1::BaseController
    def create
      @device = current_user.devices.find_or_initialize_by(token: device_params[:token])

      if @device.update(device_params)
        head 204
      else
        head 422
      end
    end

    private

    def device_params
      params.permit(:token, :platform)
    end
  end
end
