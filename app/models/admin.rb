class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :lockable, lock_strategy: :none

  ROLES = %w(basic admin)

  before_save :set_role

  #def manager?
  #  role == 'manager'
  #end

  #def basic?
  #  role == 'basic'
  #end

  private

  def set_role
    self.roles = 'basic' if new_record?
  end

end
