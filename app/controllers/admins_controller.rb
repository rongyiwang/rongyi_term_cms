class AdminsController < ApplicationController
  before_action :set_admin, except: :index
  before_filter :verify_admin, only: [:lock, :unlock, :update_roles, :edit_roles, :destroy]
  #load_resource except: :create
  #authorize_resource

  def index
    @admins = Admin.all
  end

  def edit_roles
  end

  def update_roles
    if @admin.update(admin_params)
      redirect_to admins_path, notice: '修改成功'
    else
      render action: 'edit_role'
    end
  end

  def lock
    @admin.locked_at = Time.now.utc
    @admin.save
    render 'ajax_post', locals: {model: @admin}
  end

  def unlock
    @admin.locked_at = nil
    @admin.save
    render 'ajax_post', locals: {model: @admin}
  end

  def destroy
    @admin.destroy
  end

  private
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_roles_params
    params.require(:admin).permit(:roles => [])
  end

  def verify_admin
    if current_admin.roles != 'admin'
      redirect_to root_path, notice: "没有权限"
    end
  end
end

