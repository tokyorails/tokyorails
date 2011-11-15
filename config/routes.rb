Tokyorails::Application.routes.draw do
  
  resources :events

  resources :members

  root :to => 'homepage#index'
end
