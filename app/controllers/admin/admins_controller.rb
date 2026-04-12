class Admin::AdminsController < Admin::BaseController
  before_action :set_admin, only: %i[ edit update destroy ]

  def index
    @admins = Admin.all.order(created_at: :desc)
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_path, notice: "管理者を正常に作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # パスワードが空の場合は更新しない
    if params[:admin][:password].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(admin_params)
      redirect_to admin_admins_path, notice: "管理者を正常に更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @admin == current_admin
      redirect_to admin_admins_path, alert: "自分自身を削除することはできません。"
      return
    end

    @admin.destroy
    redirect_to admin_admins_path, notice: "管理者を削除しました。"
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
