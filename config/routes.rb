Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      get '/', to: 'files#index'
      post '/file', to: "files#create"
    end
  end
end
