Rails.application.routes.draw do
  resources :brands
  resources :targets
  resources :matrices do
    resources :questions
    resources :submissions do
      resources :answers
      resources :targets
    end
  end
  get '/matrices/:matrix_id/submissions/:id/email' => 'submissions#emailpdf', as: :submissions_emailpdf
  get '/matrices/:matrix_id/submissions/:id/email-api' => 'submissions#emailpdf_api', as: :submissions_emailpdf_api
  root to: 'visitors#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :delete]
  resources :charges
end
