Rails.application.routes.draw do
  namespace :admin do
    resources :event_types
    resources :events
    root to: "events#index"
  end

  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }
  
  root to: redirect("/admin")
end
