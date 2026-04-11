Rails.application.routes.draw do
  # 一般ユーザー用：LINEログインのコールバックを指定
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :admin do
    resources :events
    resources :event_types
    resources :users, only: [ :index, :update, :destroy ]
    root to: "events#index"
  end

  # 管理者ログイン用
  devise_for :admins, path: "admin", path_names: { sign_in: "login", sign_out: "logout" }

  # アプリのトップページ（一般ユーザー用）
  # まだ一般用の画面がないので、一旦 "/admin" へのリダイレクトは残してもいいですが、
  # 本来は Event の一覧などが見れるようにしたいですね
  root to: "events#index" # ← namespace 外の events#index を想定
end
