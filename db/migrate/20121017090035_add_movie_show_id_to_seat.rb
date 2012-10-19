class AddMovieShowIdToSeat < ActiveRecord::Migration
  def change
    add_column :seats, :movie_show_id, :integer
  end
end
