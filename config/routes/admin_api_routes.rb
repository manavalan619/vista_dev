module AdminApiRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do
        with_options(except: %i[new edit]) do
          # TODO: we may want to look at shallow routes, but for now as there are
          # so many operations around assocations it makes sense to keep them verbose
          resources :business_units, path: 'units', as: :units do
            resources :branches do
              get 'staff', to: 'branches/staff#index'
              post 'staff/:user_id', to: 'branches/staff#create'
              delete 'staff/:user_id', to: 'branches/staff#destroy'
            end
          end

          namespace :staff_members, path: 'staff' do
            post :login, to: 'authentication#create'
            put 'account/confirmation', to: 'confirmations#update'
            patch 'account/confirmation', to: 'confirmations#update'
          end

          resources :staff_members, path: 'staff', as: :staff do
            put 'invite', to: 'staff_members/invitations#update'
            patch 'invite', to: 'staff_members/invitations#update'

            put 'suspend', to: 'staff_members/suspensions#suspend'
            patch 'suspend', to: 'staff_members/suspensions#suspend'
            put 'unsuspend', to: 'staff_members/suspensions#unsuspend'
            patch 'unsuspend', to: 'staff_members/suspensions#unsuspend'
          end

          resources :roles
          resources :categories
          resources :questions
        end
      end
    end
  end
end
