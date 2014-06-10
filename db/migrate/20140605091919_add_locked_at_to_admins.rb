class AddLockedAtToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :locked_at, :datetime
  end
end
