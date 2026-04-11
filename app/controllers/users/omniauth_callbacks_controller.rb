class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # LINEからのレスポンスを受けるメソッド
  def line
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @user.approved?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "LINE") if is_navigational_format?
      else
        # 未承認の場合
        session["devise.line_data"] = request.env["omniauth.auth"].except(:extra)
        redirect_to new_user_session_path, alert: "管理者による承認待ちです。"
      end
    else
      session["devise.line_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_session_path, alert: "ログインに失敗しました。"
    end
  end

  def failure
    redirect_to root_path
  end
end
