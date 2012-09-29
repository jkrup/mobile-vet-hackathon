class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :price, :precision => 9, :scale => 2
      t.boolean :is_active
      t.string :role

      t.timestamps
    end
  end
end
