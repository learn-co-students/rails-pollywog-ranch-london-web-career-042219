class CreateFrogs < ActiveRecord::Migration
  # code goes here
  def change 
    create_table :frogs do |t| 
      t.string :name 
      t.integer :pond_id
    end 
  end 

end
