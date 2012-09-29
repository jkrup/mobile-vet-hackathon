class CreateBillingItems < ActiveRecord::Migration
  def change
    create_table :billing_items do |t|
      t.integer :visit_id
      t.integer :item_id
      t.integer :pet_id

      t.timestamps
    end
  end
end
