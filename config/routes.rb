Tokyorails::Application.routes.draw do
  resources :members

  root :to => 'homepage#index'
end
