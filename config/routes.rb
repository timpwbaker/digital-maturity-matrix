Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      resource :query, only: [:create]
    end
  end
  root to: 'visitors#index'

  resources :brands, only: [:new, :edit, :create, :update]
  resources :matrices do
    resources :questions, only: [:new, :edit, :create, :update, :destroy]
    resources :submissions do
      resource :dispatch_pdfs, only: [:create]
    end
  end
  resources :benchmark_queries, only: [:new, :create, :show]

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :delete] do
    resource :api_key, only: [:create, :show]
  end

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"
end
