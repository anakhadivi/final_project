class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :title
  		t.text :text
  		t.integer :user_id
  	end
  end
end
