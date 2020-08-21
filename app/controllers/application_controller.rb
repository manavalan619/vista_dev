class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  add_flash_types :success, :error, :warning

  layout :layout_by_resource

  devise_group :non_user, contains: %i[vista_admin staff_member]

  private

  def info_for_paper_trail
    { ip_address: request.remote_ip, user_agent: request.user_agent }
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def convert_params_to_snakecase
    underscore_hash = -> (hash) do
      hash.transform_keys!(&:underscore)
      hash.each do |key, value|
        if value.is_a?(ActionController::Parameters)
          underscore_hash.call(value)
        elsif value.is_a?(Array)
          value.each do |item|
            next unless item.is_a?(ActionController::Parameters)
            underscore_hash.call(item)
          end
        end
      end
    end
    underscore_hash.call(params)
  end
end
