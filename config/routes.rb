Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :brands, only: [:new, :edit, :create, :update]
  resources :matrices do
    resources :questions, only: [:new, :edit, :create, :update, :destroy]
    resource :submissions_csv, only: [:create]
    resources :submissions do
      resource :dispatch_pdfs, only: [:create]
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :delete] do
    resource :api_key, only: [:create, :show]
  end
end
