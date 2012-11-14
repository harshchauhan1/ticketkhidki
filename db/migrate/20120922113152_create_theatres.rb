class CreateTheatres < ActiveRecord::Migration
  def change
    create_table :theatres do |t|
      t.integer :no_of_audis
      t.string :location
      
      t.timestamps
    end
  end
end
