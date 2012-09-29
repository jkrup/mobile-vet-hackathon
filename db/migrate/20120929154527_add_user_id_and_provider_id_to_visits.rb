class AddUserIdAndProviderIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :client_id, :integer
    add_column :visits, :provider_id, :integer
  end
end
