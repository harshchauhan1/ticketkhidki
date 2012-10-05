class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.datetime :release_date
      t.timestamps
    end
  end
end
