class RemoveAppointmentIdFromVisit < ActiveRecord::Migration
  def up
    remove_column :visits, :appointment_id
  end

  def down
    add_column :visits, :appointment_id, :integer
  end
end
