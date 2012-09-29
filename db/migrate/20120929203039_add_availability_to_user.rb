class AddAvailabilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :availability_serialized, :text
  end
end
