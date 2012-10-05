class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :movie_id
      t.datetime :timing
      t.integer :audi_id

      t.timestamps
    end
  end
end
