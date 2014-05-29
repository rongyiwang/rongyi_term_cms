class CreateTerminals < ActiveRecord::Migration
  def change
    create_table :terminals do |t|

      t.timestamps
    end
  end
end
