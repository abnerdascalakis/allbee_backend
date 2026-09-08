Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :produtos, only: %i[index show create update destroy]
      resources :categorias, only: %i[index show create update destroy]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
