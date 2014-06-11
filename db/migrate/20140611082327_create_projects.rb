class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :mall_code
      t.string :name
      t.string :region
      t.string :city
      t.string :type
      t.string :manager

      t.timestamps
    end
  end
end
