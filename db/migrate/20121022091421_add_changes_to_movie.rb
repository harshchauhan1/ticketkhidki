class AddChangesToMovie < ActiveRecord::Migration
  def up
  	change_table :movies do |t|
  		t.string :image_url
  	end
  end
  	
  	def down
  		remove_column :movies, :image_url
  	end
end
