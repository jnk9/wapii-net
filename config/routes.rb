Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    get '/users', to: 'users#index'
    get '/users/influencers', to: 'users#influencers'
    get '/trending/:limit', to: 'posts#trending'
  end
end
