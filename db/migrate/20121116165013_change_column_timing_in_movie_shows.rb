class ChangeColumnTimingInMovieShows < ActiveRecord::Migration
  def up
  	change_column :movie_shows, :timing, :datetime
  end

  def down
  	# change_column :movie_shows, :timing, :time
  end
end
