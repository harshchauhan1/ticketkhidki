class RenameColumnShowIdToMovieShowIdInBookings < ActiveRecord::Migration
  def change
  	rename_column :bookings, :show_id, :movie_show_id
  end
end
