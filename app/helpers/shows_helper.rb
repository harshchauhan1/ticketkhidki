module ShowsHelper
	def movie_show_ids
		@movie_shows.collect(&:id).join(',')
	end
end