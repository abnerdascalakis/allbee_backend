Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :produtos, only: %i[index show create update destroy]
      resources :categorias, only: %i[index show create update destroy]
      resources :enderecos, only: %i[index show create update destroy]

      resource :carrinho, only: :show do
        resources :itens, controller: "itens_carrinho", only: %i[create update destroy]
      end

      resources :pedidos, only: %i[index show create]

      post "cadastro", to: "usuarios#create"
      post "login", to: "sessoes#create"
      get "perfil", to: "usuarios#perfil"

      namespace :admin do
        resources :usuarios, only: %i[index show update destroy]
        resources :pedidos, only: %i[index show update]
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
