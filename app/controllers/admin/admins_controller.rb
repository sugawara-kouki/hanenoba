class Admin::AdminsController < Admin::BaseController
  include AdminSortable
  before_action :set_admin, only: %i[ edit update destroy ]

  def index
    s = sort_params("created_at", "desc", %w[email created_at])
    @admins = Admin.all.order("#{s[:column]} #{s[:direction]}")
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_path, notice: t("admin.notices.created", model: Admin.model_name.human)
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
      redirect_to admin_admins_path, notice: t("admin.notices.updated", model: Admin.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @admin == current_admin
      redirect_to admin_admins_path, alert: t("admin.notices.cannot_delete_self")
      return
    end

    @admin.destroy
    redirect_to admin_admins_path, notice: t("admin.notices.destroyed", model: Admin.model_name.human)
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
