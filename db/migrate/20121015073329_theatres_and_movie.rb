class TheatresAndMovie < ActiveRecord::Migration
  def up
  	create_table :movies_theatres, :id => false do |t|
        t.integer :movie_id
        t.integer :theatre_id
        
      end
  end

  def down
  	drop_table :movies_theatres
  end
end
