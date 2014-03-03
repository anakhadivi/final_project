class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :gender
  		t.string :age
  		t.string :hometown
  		t.integer :user_id
  	end
  end
end
