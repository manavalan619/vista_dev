require 'api_constraints'
require 'admin_constraints'
require 'partner_constraints'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # devise_for :users if Rails.env.development? || Rails.env.test?
  devise_for :users, skip: %i[sessions registrations passwords]

  constraints AdminConstraints.new do
    as :vista_admin do
      patch '/account/confirmation', to: 'admin/vista_admins/confirmations#update', as: :update_vista_admin_confirmation
    end
    devise_for :vista_admins, path: 'account', controllers: { confirmations: 'admin/vista_admins/confirmations' }

    authenticate :vista_admin do
      mount Sidekiq::Web => '/sidekiq'
      mount PgHero::Engine, at: 'pghero'
    end

    scope module: :admin, as: :admin do
      resources :cities
      resources :data_imports, only: %i[index new create show], path: 'data-imports'
      resources :categories do
        put :reorder, on: :collection, to: 'categories/reorder#update'
      end
      resources :partner_categories, path: 'partner-categories' do
        put :reorder, on: :collection, to: 'partner_categories/reorder#update'
      end
      resources :questions
      resources :organisations do
        scope module: :staff, path: 'staff' do
          resources :admins, path: 'admins'
        end
        resources :business_units do
          resources :branches
        end
      end
      resources :articles, except: :create do
        post :photos, on: :member, to: 'articles/photos#create'
      end
      resources :videos
      resources :preference_groups, path: 'preference-groups'
      resources :releases, only: %i[index create destroy] do
        get :download, on: :member
      end
      root to: 'questions#index'
    end
  end

  constraints PartnerConstraints.new do
    as :staff_member do
      patch '/account/confirmation', to: 'partners/staff_members/confirmations#update', as: :update_staff_member_confirmation
    end
    devise_for :staff_members, path: 'account', controllers: { confirmations: 'partners/staff_members/confirmations' }

    scope module: :partners, as: :partners do
      # resources :categories
      # resources :questions
      scope module: :staff, path: 'staff' do
        resources :staff_members, path: 'staff-members'
        resources :branch_managers, path: 'branch-managers'
        resources :admins, path: 'admins'
      end
      resources :business_units, path: 'business-units' do
        resources :branches
        resources :roles
        resources :member_request_types, path: 'request-types'
      end
      resources :roles
      resources :questions, only: :index
      root to: 'staff/staff_members#index'
    end
  end

  constraints ApiConstraints.new do
    authenticate :vista_admin do
      mount GraphiQL::Rails::Engine,
            at: '/graphiql',
            graphql_path: '/partners/v1/graphql'
      mount GraphqlPlayground::Rails::Engine,
            at: '/graphql/playground',
            graphql_path: '/partners/v1/graphql'
    end

    scope module: :api, as: :api, defaults: { format: :json } do
      # extend AdminApiRoutes
      extend Api::Partners::V1Routes

      namespace :v1 do
        resources :sync, only: %i[index create]
        get 'sync/check', to: 'sync/check#index'

        get :me, to: 'me#show'
        put :me, to: 'me#update'
        patch :me, to: 'me#update'

        post :mood, to: 'mood#create'

        get :status, to: 'status#ping'
        post :devices, to: 'devices#create'

        post 'password/reset', to: 'password_resets#create'
        put 'password/reset', to: 'password_resets#update'
        patch 'password/reset', to: 'password_resets#update'

        post :login, to: 'users/authentication#create'
        post :register, to: 'users/registration#create'

        resources :feed, only: :index
        resources :notifications, only: %i[index update]
        resources :content_categories, only: :index, path: 'content-categories'

        resources :branches, path: 'partners', only: %i[index show] do
          get :check, on: :collection, to: 'branches/check#index'
          get :categories, on: :collection, to: 'branches/categories#index'

          member do
            post :share, to: 'branches/share#create'
            delete :revoke, to: 'branches/share#destroy'
            post 'check-in', to: 'branches/check_in#create'
            get :interactions, to: 'branches/interactions#index'
          end

          delete :revoke, to: 'branches/share#revoke_all', on: :collection
        end

        resources :categories, only: %i[index show] do
          member do
            post :ignore, to: 'categories/ignore#create'
            delete :ignore, to: 'categories/ignore#destroy'
          end
        end

        resources :cities, only: :index
        resources :member_requests, only: [:index, :show, :create] do
          member do
            post :mark_as_read
            post :send_message
            get :request_details
          end
        end

        resources :questions, only: %i[index show] do
          member do
            # get :answers, to: 'answers#index'
            # post :answers, to: 'answers#create'
            post :answer, to: 'questions/answer#create'
            # get :answer, to: 'answers#show'
            # put :answer, to: 'answers#update'
            # patch :answer, to: 'answers#update'
            delete :answer, to: 'questions/answer#destroy'
          end
        end

        get 'releases/check', to: 'releases#check'
        get 'releases/latest', to: 'releases#latest'
      end
    end
  end

  # constraints subdomain: 'admin' do
  #   root 'react_entry#index'
  #   get '*path', to: 'react_entry#index'
  # end
end
