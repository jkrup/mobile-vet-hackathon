class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.text :requested_slots_serialized
      t.integer :user_id
      t.integer :assigned_vet_id
      t.integer :round_count
      t.string :visit_type
      t.text :nos_serialized

      t.timestamps
    end
  end
end
