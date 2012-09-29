class RemoveUserIdFromVisits < ActiveRecord::Migration
  def change
    remove_column :visits, :user_id
  end
end
