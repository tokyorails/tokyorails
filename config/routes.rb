Tokyorails::Application.routes.draw do

  scope "(:locale)", :locale => /en|ja/ do
    resources :members
    resources :events
  end

  match '/:locale' => 'homepage#index', :as => :locale_root

  root :to => 'homepage#index'
end
