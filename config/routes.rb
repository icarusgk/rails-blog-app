Rails.application.routes.draw do
  # Posts
  root "posts#index"

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :comments, only: :index
end
