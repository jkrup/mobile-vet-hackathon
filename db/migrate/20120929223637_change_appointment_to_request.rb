class ChangeAppointmentToRequest < ActiveRecord::Migration
  def change
    rename_table :appointments, :requests
  end
end
