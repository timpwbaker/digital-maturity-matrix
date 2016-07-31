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
  root to: 'visitors#index'
  devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations" }
  resources :users do
  	resources :benchmark_applications
  end
  resources :charges
end
