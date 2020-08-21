module Api::Partners::V1Routes
  def self.extended(router)
    router.instance_exec do
      namespace :partners do
        namespace :v1 do
          post '/management/login', to: 'management/authentication#create'
          post '/management/password/reset', to: 'management/password_reset#create'
          put '/management/password/reset', to: 'management/password_reset#update'
          post '/staff/login', to: 'staff/authentication#create'

          post '/graphql', to: 'graphql#execute'

          with_options(except: %i[new edit]) do
            resources :roles, only: :index
          end
        end
      end
    end
  end
end
