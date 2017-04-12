Rails.application.routes.draw do

  root 'welcome#index'
  
   resources :users do 
   	member do
   		get :confirm_email
   	end 
   end


   get '/signup', to:'users#new'
   get '/login', to:'sessions#new'
   post '/login',  to: 'sessions#create'
   delete '/logout', to: 'sessions#destroy'
    default_url_options :host => "localhost:3000"


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
