class Admin::UsersController < Admin::BaseController
  include AdminSortable
  def index
    s = sort_params("created_at", "desc", %w[name email approved created_at])
    @users = User.all.order("#{s[:column]} #{s[:direction]}")
  end

  def update
    @user = User.find(params[:id])
    if @user.update(approved: !@user.approved)
      redirect_to admin_users_path, notice: t('admin.notices.status_updated', name: @user.name || @user.email)
    else
      redirect_to admin_users_path, alert: t('admin.notices.update_failed')
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: t('admin.notices.destroyed', model: User.model_name.human)
  end

  def impersonate
    return unless Rails.env.development?

    @user = User.find(params[:id])
    sign_in(:user, @user)
    redirect_to root_path, notice: t('admin.notices.impersonated', name: @user.name || @user.email)
  end
end
