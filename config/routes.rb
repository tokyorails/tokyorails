# -*- encoding : utf-8 -*-
Tokyorails::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  scope "(:locale)", :locale => /en|ja/ do
    resources :members
    resources :events
    resources :photos
    resources :projects
  end

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/logout' => 'sessions#destroy', :as => :logout

  match '/:locale' => 'homepage#index', :as => :locale_root

  root :to => 'homepage#index'
end
