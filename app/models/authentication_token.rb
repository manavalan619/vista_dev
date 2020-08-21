# == Schema Information
#
# Table name: authentication_tokens
#
#  id           :bigint(8)        not null, primary key
#  context      :string
#  body         :string
#  user_type    :string
#  user_id      :bigint(8)
#  last_used_at :datetime
#  ip_address   :inet
#  user_agent   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_authentication_tokens_on_context                (context)
#  index_authentication_tokens_on_user_type_and_user_id  (user_type,user_id)
#

class AuthenticationToken < ApplicationRecord
  CONTEXTS = %w[manager staff].freeze

  belongs_to :user, polymorphic: true

  validates :context, presence: true, inclusion: { in: CONTEXTS }

  scope :for_context, ->(context) { context ? where(context: context) : all }

  class << self
    def decode(token_from_headers)
      Devise.token_generator.digest(self, :body, token_from_headers)
    end

    def find_for_context(context, token)
      for_context(context).find_by(body: token)
    end

    def create_and_return_staff_token(resource, request)
      create_and_return_token('staff', resource, request)
    end

    def create_and_return_manager_token(resource, request)
      create_and_return_token('manager', resource, request)
    end

    def create_and_return_token(context, resource, request)
      token, token_body = Devise.token_generator.generate(self, :body)

      resource.authentication_tokens
              .create! body: token_body,
                       context: context,
                       last_used_at: Time.current,
                       ip_address: request.remote_ip,
                       user_agent: request.user_agent

      token
    end

    def create_and_return_analytics_token
      Digest::SHA1.hexdigest(ENV['ANALYTICS_SECRET'])
    end
  end
end
