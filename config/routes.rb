Rails.application.routes.draw do
  # 一般ユーザー用：LINEログインのコールバックを指定
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "mypage/calendar", to: "mypages#calendar", as: :mypage_calendar

  resources :events, only: [ :index, :show ] do
    resources :bookings, only: [ :create ] do
      post :bulk_create, on: :collection
    end
  end

  namespace :admin do
    root to: "dashboard#show"
    resources :events
    resources :event_types, except: [ :show ]
    resources :users, only: [ :index, :update, :destroy ] do
      post :impersonate, on: :member if Rails.env.development?
    end
    resources :bookings, only: [ :destroy ]
    resources :admins, except: [ :show ]
  end

  # 管理者ログイン用
  devise_for :admins, path: "admin", path_names: { sign_in: "login", sign_out: "logout" }

  # アプリのトップページ（一般ユーザー用）
  # まだ一般用の画面がないので、一旦 "/admin" へのリダイレクトは残してもいいですが、
  # 本来は Event の一覧などが見れるようにしたいですね
  root to: "events#index" # ← namespace 外の events#index を想定
end
