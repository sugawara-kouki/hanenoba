class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(approved: !@user.approved)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name || @user.email}」の状態を更新しました。"
    else
      redirect_to admin_users_path, alert: "更新に失敗しました。"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name || @user.email}」を削除しました。"
  end
end
