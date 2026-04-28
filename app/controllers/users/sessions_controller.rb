class Users::SessionsController < Devise::SessionsController
  # ログイン画面を表示する
  def new
    # 親の処理（Devise::SessionsController#new）を呼ぶ代わりに
    # LINEログインボタンのみの画面を表示する
  end
end
