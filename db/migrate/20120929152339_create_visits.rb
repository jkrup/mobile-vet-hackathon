class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.boolean :is_home
      t.integer :user_id
      t.integer :appointment_id

      t.timestamps
    end
  end
end
