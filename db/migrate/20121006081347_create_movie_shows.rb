class CreateMovieShows < ActiveRecord::Migration
  def change
    create_table :movie_shows do |t|
      t.time :timing
      t.integer :movie_id
      t.integer :audi_id

      t.timestamps
    end
  end
end
