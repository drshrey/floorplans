Rails.application.routes.draw do
  resources :floorplans
  resources :projects
  resources :versioned_files
  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
