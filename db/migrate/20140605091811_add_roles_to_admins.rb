class AddRolesToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :roles, :string
  end
end
