Rails.application.routes.draw do
  # Posts
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :comments, only: :index
end
