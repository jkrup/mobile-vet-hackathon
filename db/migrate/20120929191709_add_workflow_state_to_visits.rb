class AddWorkflowStateToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :workflow_state, :string
  end
end
