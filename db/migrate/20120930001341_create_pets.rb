class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :specie
      t.integer :age
      t.text :medical_history
      t.integer :client_id
      
      t.timestamps
    end
  end
end
