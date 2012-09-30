class AddStartTimeAndVisitTypeToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :start_time, :time
    add_column :visits, :visit_type, :string
  end
end
